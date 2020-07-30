//  VideosVC.swift
//  Picturize
//
//  Created by Crocodic on 02/07/20.
//  Copyright © 2020 WradDev. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class VideosVC: UIViewController, IndicatorInfoProvider {
	
	@IBOutlet var refreshBtn: UIButton!
	@IBOutlet var errorView: UIView!
	@IBOutlet var collectionView: UICollectionView!
	
	var indicatorView: UIActivityIndicatorView?
	
	let viewModel = VideosVM()

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

		fetchVideos()
    }
	
	private func showDefaultState() {
		errorView.isHidden = true
		self.indicatorView = UIActivityIndicatorView.customIndicator(at: self.view.center)
		self.view.addSubview(self.indicatorView!)
		self.indicatorView?.startAnimating()
	}
	
	private func fetchVideos() {
		viewModel.fetchVideos(
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
		return IndicatorInfo(title: "VIDEOS")
	}
	
	@IBAction func refreshPageAction(_ sender: Any) {
		self.indicatorView?.startAnimating()
		fetchVideos()
	}
	
}

// MARK: Extended function
private extension VideosVC {
	func isLoadingCell(for indexPath: IndexPath) -> Bool {
		return indexPath.item >= viewModel.getVideosCount - 1
	}
	
	func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
		let indexPathsForVisibleItems = self.collectionView.indexPathsForVisibleItems
		let indexPathsIntersection = Set(indexPathsForVisibleItems).intersection(indexPaths)
		return Array(indexPathsIntersection)
	}
}

extension VideosVC: PinterestLayoutDelegate {
	func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
		let videoWidth = CGFloat(viewModel.getVideos[indexPath.item].width)
		let videoHeight = CGFloat(viewModel.getVideos[indexPath.item].height)
		let ratio = (videoWidth / videoHeight).rounded(toPlaces: 3)
		let width = (collectionView.bounds.size.width / 2)
		let height: CGFloat = width / ratio
		return height
	}
}

// MARK: CollectionView
extension VideosVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSourcePrefetching {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return self.viewModel.getVideosCount
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCell", for: indexPath) as! VideoCell
		
		if isLoadingCell(for: indexPath) {
			print("LOADING")
			cell.contentView.backgroundColor = .white
			let indicatorView = UIActivityIndicatorView.customIndicator(at: cell.contentView.center)
			cell.contentView.addSubview(indicatorView)
			indicatorView.startAnimating()
		} else {
			cell.viewModel = self.viewModel.getItemViewModel(indexPath: indexPath)
		}
		return cell
	}
	
	// Prefetching data here
	func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
		if indexPaths.contains(where: isLoadingCell(for:)) {
			self.fetchVideos()
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let storyboard = UIStoryboard(name: "Detail", bundle: nil)
		let destController = storyboard.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
		destController.viewModel.video = viewModel.getSingleVideo(indexPath: indexPath)
		destController.isVideo = true
		
		self.navigationController?.pushViewController(destController, animated: true)
	}

}
