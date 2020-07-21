//
//  SearchVC.swift
//  Picturize
//
//  Created by Crocodic on 09/07/20.
//  Copyright © 2020 WradDev. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {
	let viewModel = SearchVM()
	
	@IBOutlet var collectionView: UICollectionView!
	@IBOutlet var errorView: UIView!
	@IBOutlet var baseView: UIView!
	@IBOutlet var refreshBtn: UIButton!
	
	var indicatorView: UIActivityIndicatorView?
	let searchController = UISearchController(searchResultsController: nil)
	
	var query = ""
	var unSubmittedQuery = ""
	var scopePosition = 0
	
    override func viewDidLoad() {
        super.viewDidLoad()
//		let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
//		if #available(iOS 13.0, *) {
//			let touch = UIHoverGestureRecognizer(target: self, action: #selector(dismissKeyboard))
//			view.addGestureRecognizer(touch)
//		}
//		view.addGestureRecognizer(tap)

		self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
		
		showDefaultState()
		setupSearchBar()
		
		refreshBtn.layer.cornerRadius = 8
		collectionView.prefetchDataSource = self
		collectionView.dataSource = self
		collectionView.delegate = self
		
		collectionView.keyboardDismissMode = .onDrag
		
	}
	
	private func setupSearchBar() {
		searchController.searchResultsUpdater = self
		searchController.obscuresBackgroundDuringPresentation = false
		searchController.searchBar.placeholder = "Ocean"
		searchController.searchBar.sizeToFit()
		searchController.searchBar.delegate = self
		searchController.searchBar.scopeButtonTitles = ["Photos", "Videos"]
		searchController.searchBar.becomeFirstResponder()
		navigationItem.searchController = searchController
		definesPresentationContext = true
	}
	
	func showDefaultState() {
		errorView.isHidden = true
		baseView.isHidden = false
		indicatorView = UIActivityIndicatorView.customIndicator(at: self.view.center)
		self.view.addSubview(indicatorView!)
	}
	
	@objc func dismissKeyboard() {
		self.searchController.searchBar.endEditing(true)
	}
	
	/// Start to fetch when user click 'Search' button in their keyboard
	/// (Photos)
	func fetchPhotosByQuery(dataQuery: String) {
		self.viewModel.fetchPhotosByUserQuery(
			onSuccess: { (message) in
				print(message)
				if self.indicatorView!.isAnimating {
					self.collectionView.setContentOffset(CGPoint.zero, animated: false)
					self.indicatorView?.stopAnimating()
				}
				self.baseView.isHidden = true
				self.errorView.isHidden = true
				self.collectionView.reloadData()
				
				// If array is empty
				if self.viewModel.getPhotosResultsItemCount == 0 {
					self.showToast(message: "Nothings found")
					self.baseView.isHidden = false
				}
				
		}, onFailed: { (message) in
			print(message)
			if self.indicatorView!.isAnimating {
				self.collectionView.setContentOffset(CGPoint.zero, animated: false)
				self.indicatorView?.stopAnimating()
			}
			self.baseView.isHidden = true
			self.errorView.isHidden = false
		}, forWhat: dataQuery)
	}
	
	/// (Videos)
	func fetchVideosByQuery(dataQuery: String) {
		self.viewModel.fetchVideosByUserQuery(
			onSuccess: { (message) in
				print(message)
				if self.indicatorView!.isAnimating {
					self.collectionView.setContentOffset(CGPoint.zero, animated: false)
					self.indicatorView?.stopAnimating()
				}
				self.baseView.isHidden = true
				self.errorView.isHidden = true
				self.collectionView.reloadData()
				
				// If array is empty
				if self.viewModel.getVideosResultsItemCount == 0 {
					self.showToast(message: "Nothings found")
					self.baseView.isHidden = false
				}
		}, onFailed: { (message) in
			print(message)
			if self.indicatorView!.isAnimating {
				self.collectionView.setContentOffset(CGPoint.zero, animated: false)
				self.indicatorView?.stopAnimating()
			}
			self.baseView.isHidden = true
			self.errorView.isHidden = false
		}, forWhat: dataQuery)
	}
	
	// Refresh button click
	@IBAction func refreshPageAction(_ sender: Any) {
		if !self.query.isEmpty {
			self.indicatorView?.startAnimating()
			self.viewModel.resetList(position: self.scopePosition)
			switch scopePosition {
			case 0:
				fetchPhotosByQuery(dataQuery: query)
			case 1:
				fetchVideosByQuery(dataQuery: query)
			default:
				fetchPhotosByQuery(dataQuery: query)
			}
		}
	}
	
}

// MARK: - Main extended function
private extension SearchVC {
	func isLoadingCell(for indexPath: IndexPath) -> Bool {
		if scopePosition == 0 {
			return indexPath.item >= viewModel.getPhotosResultsItemCount - 1
		} else {
			return indexPath.item >= viewModel.getVideosResultsItemCount - 1
		}
	}
	
	func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
		let indexPathsForVisibleItems = self.collectionView.indexPathsForVisibleItems
		let indexPathsIntersection = Set(indexPathsForVisibleItems).intersection(indexPaths)
		return Array(indexPathsIntersection)
	}
}

// MARK: - Search Bar
extension SearchVC: UISearchBarDelegate, UISearchResultsUpdating {
	
	func updateSearchResults(for searchController: UISearchController) {
		self.unSubmittedQuery = searchController.searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
		print("unSubmittedQuery:", unSubmittedQuery)
	}
	
	// Search button click
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		guard let text = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
		if text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
			self.query = self.query + ""
			self.searchController.searchBar.text = self.query.trimmingCharacters(in: .whitespacesAndNewlines)
		} else {
			self.query = text
		}
		print("query:", query)
		self.indicatorView?.startAnimating()
		self.viewModel.resetList(position: self.scopePosition)
		switch scopePosition {
		case 0:
			fetchPhotosByQuery(dataQuery: query)
		case 1:
			fetchVideosByQuery(dataQuery: query)
		default:
			fetchPhotosByQuery(dataQuery: query)
		}
	}
	
	// Scope bar index changed
	func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
		print("#SCOPE INDEX CHANGED")
		self.searchController.searchBar.endEditing(true)
		self.scopePosition = selectedScope
		
		if !self.query.isEmpty {
			
			
			if !(self.query == self.unSubmittedQuery) {
				self.searchController.searchBar.text = self.query.trimmingCharacters(in: .whitespacesAndNewlines)
				self.query = self.searchController.searchBar.text ?? ""
				print("RESET QUERY TEXT")
			}
			
			self.indicatorView?.startAnimating()
			self.viewModel.resetList(position: self.scopePosition)
			switch scopePosition {
			case 0:
				print("FETCH 0")
				fetchPhotosByQuery(dataQuery: query)
			case 1:
				print("CASE 1")
				fetchVideosByQuery(dataQuery: query)
			default:
				print("CASE DEF")
				fetchPhotosByQuery(dataQuery: query)
			}
		} else {
			print("OWHH NING KENE TO!")
		}
	}
	
	// Cancel button click
	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		self.navigationController?.popViewController(animated: true)
	}
	
}

// MARK: - Collectionview
extension SearchVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSourcePrefetching {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		if scopePosition == 0 {
			return self.viewModel.getPhotosResultsItemCount
		} else {
			return self.viewModel.getVideosResultsItemCount
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCell", for: indexPath) as! SearchCell
		cell.scopePosition = self.scopePosition
		
		if isLoadingCell(for: indexPath) {
			print("LOADING")
			cell.contentView.backgroundColor = .white
			let indicatorView = UIActivityIndicatorView.customIndicator(at: cell.contentView.center)
			cell.contentView.addSubview(indicatorView)
			indicatorView.startAnimating()
			
			if self.viewModel.getPhotosResultsItemCount <= self.viewModel.perPage && self.viewModel.page == 1 {
				print("Just one page")
				indicatorView.stopAnimating()
				indicatorView.removeFromSuperview()
				cell.viewModel = self.viewModel.getItemViewModel(scopeState: self.scopePosition, indexPath: indexPath)
			}
			
		} else {
			cell.viewModel = self.viewModel.getItemViewModel(scopeState: self.scopePosition, indexPath: indexPath)
		}
		return cell
	}
	
	// 858 092
	// Prefetch data
	func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
		if indexPaths.contains(where: self.isLoadingCell(for:)) {
			
//			if self.viewmod
			
			if scopePosition == 0 {
				self.fetchPhotosByQuery(dataQuery: self.query)
			} else {
				self.fetchVideosByQuery(dataQuery: self.query)
			}
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let storyboard = UIStoryboard(name: "Detail", bundle: nil)
		let destController = storyboard.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
		
		if scopePosition == 0 {
			print("#IS PHOTO")
			destController.viewModel.photo = self.viewModel.getSinglePhotoResult(indexPath: indexPath)
			destController.isVideo = false
		} else {
			print("#IS VIDEO")
			destController.viewModel.video = self.viewModel.getSingleVideoResult(indexPath: indexPath)
			destController.isVideo = true
		}
		self.navigationController?.pushViewController(destController, animated: true)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let width = collectionView.bounds.size.width / 2
		let height = width
		
		return CGSize(width: width, height: height)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return 0
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 0
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
	}
	
}
