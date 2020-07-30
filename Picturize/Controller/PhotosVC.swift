//  PhotosVC.swift
//  Picturize
//
//  Created by Crocodic on 02/07/20.
//  Copyright © 2020 WradDev. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class PhotosVC: UIViewController, IndicatorInfoProvider {
	private let viewModel = PhotosVM()
	
	@IBOutlet var refreshBtn: UIButton!
	@IBOutlet var errorView: UIView!
	@IBOutlet var collectionView: UICollectionView!
	
	var indicatorView: UIActivityIndicatorView?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		if let layout = collectionView.collectionViewLayout as? PinterestLayout {
			layout.delegate = self
		}
		showDefaultState()
		
		refreshBtn.layer.cornerRadius = 8
		
		collectionView.prefetchDataSource = self
		collectionView.dataSource = self
		collectionView.delegate = self
		
		fetchPhotos()
	}
	
	func showDefaultState() {
		errorView.isHidden = true
		indicatorView = UIActivityIndicatorView.customIndicator(at: self.view.center)
		self.view.addSubview(indicatorView!)
		indicatorView?.startAnimating()
	}
	
	func fetchPhotos() {
		self.viewModel.fetchCuratedPhotos(
			onSuccess: { (message, indexPathToReloads) in
				if self.indicatorView!.isAnimating {
					self.indicatorView?.stopAnimating()
				}
				self.errorView.isHidden = true
				self.collectionView.reloadData()
				
				guard let newIndexPathsToReload = indexPathToReloads else {
					print("PAGE 1/LAST")
					return
				}
				let indexPathsToReload = self.visibleIndexPathsToReload(intersecting: newIndexPathsToReload)
				
				print("PAGE > 1")
				
		}, onFailed: { (message) in
			print(message)
			if self.indicatorView!.isAnimating {
				self.indicatorView?.stopAnimating()
			}
			self.errorView.isHidden = false
		})
	}
	
	func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
		return IndicatorInfo(title: "PHOTOS")
	}
	
	@IBAction func refreshPageAction(_ sender: Any) {
		self.indicatorView?.startAnimating()
		fetchPhotos()
	}
}

// MARK: Extended function
private extension PhotosVC {
	func isLoadingCell(for indexPath: IndexPath) -> Bool {
		return indexPath.item >= viewModel.getPhotosCount - 1
	}
	
	func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
		let indexPathsForVisibleItems = self.collectionView.indexPathsForVisibleItems
		let indexPathsIntersection = Set(indexPathsForVisibleItems).intersection(indexPaths)
		return Array(indexPathsIntersection)
	}
}

extension PhotosVC: PinterestLayoutDelegate {
	func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
		let imageWidth = CGFloat(viewModel.getPhotos[indexPath.item].width)
		let imageHeight = CGFloat(viewModel.getPhotos[indexPath.item].height)
		let ratio = (imageWidth / imageHeight).rounded(toPlaces: 3)
		let width = (collectionView.bounds.size.width / 2)
		let height: CGFloat = width / ratio
		return height
	}
}

// MARK: - CollectionView
extension PhotosVC: UICollectionViewDataSource, UICollectionViewDelegate , UICollectionViewDataSourcePrefetching {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return self.viewModel.getPhotosCount
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
		
		if isLoadingCell(for: indexPath) {
			cell.contentView.backgroundColor = .white
			let indicatorView = UIActivityIndicatorView.customIndicator(at: cell.contentView.center)
			cell.contentView.addSubview(indicatorView)
			indicatorView.startAnimating()
		} else {
			cell.viewModel = self.viewModel.getItemViewModel(indexPath: indexPath)
		}
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let storyboard = UIStoryboard(name: "Detail", bundle: nil)
		let destController = storyboard.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
		destController.viewModel.photo = viewModel.getSinglePhoto(indexPath: indexPath)
		destController.isVideo = false

		self.navigationController?.pushViewController(destController, animated: true)
	}
	
	// Prefetch Data
	func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
		if indexPaths.contains(where: isLoadingCell(for:)) {
			self.fetchPhotos()
		}
	}
	
}

extension CGFloat {
    func rounded(toPlaces places:Int) -> CGFloat {
        let divisor = pow(10.0, CGFloat(places))
        return (self * divisor).rounded() / divisor
    }
}

