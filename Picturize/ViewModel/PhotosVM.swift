//
//  PhotosVM.swift
//  Picturize
//
//  Created by Crocodic on 03/07/20.
//  Copyright © 2020 WradDev. All rights reserved.
//

import Alamofire
import Foundation

class PhotosVM {
		
	var photoList = [Photo]()
	var page = 1
	var isFetchingInProgress = false
	
	//MARK : Try to decode response with JSONDecoder()

	func fetchCuratedPhotos(onSuccess: ((String, [IndexPath]?) -> Void)?, onFailed: ((String) -> Void)?) {
		let curatedUrl = ApiRequest.photosBaseUrl + "/curated"
		let param: Parameters = ["per_page" : "20", "page": page]

		guard !isFetchingInProgress else { return }
		
		self.isFetchingInProgress = true
		
		AF.request(curatedUrl, parameters: param, headers: ApiRequest.headers)
			.validate()
			.responseDecodable(of: Photos.self) { (response) in
				guard let photos = response.value else {
					onFailed?("#PHOTOS -> Error: \(String(describing: response.error!.errorDescription))")
					self.isFetchingInProgress = false
					return
				}
				if !photos.photos.isEmpty {
					self.isFetchingInProgress = false
					self.page += 1
					self.photoList.append(contentsOf: photos.photos)
					
					if photos.page > 1 {
						let indexPathsToReload = self.calculateIndexPathsToReload(from: photos.photos)
						onSuccess?("#PHOTOS -> Success!", indexPathsToReload)
					} else {
						onSuccess?("#PHOTOS -> Success!", .none)
					}
				} else {
					onSuccess?("#PHOTOS -> Success!", .none)
				}
		}
	}
	
	private func calculateIndexPathsToReload(from newPhotos: [Photo]) -> [IndexPath] {
		let startIndex = self.getPhotosCount - newPhotos.count
		let endIndex = startIndex + newPhotos.count
		return (startIndex..<endIndex).map {
			IndexPath(item: $0, section: 0)
		}
	}
	
	func getItemViewModel(indexPath: IndexPath) -> PhotoItemVM {
		return PhotoItemVM(photos: self.photoList, indexPath: indexPath)
	}
	
	var getPhotos: [Photo] {
		return self.photoList
	}
	
	var getPhotosCount: Int {
		return self.photoList.count
	}
	
	func getSinglePhoto(indexPath: IndexPath) -> Photo {
		return self.photoList[indexPath.item]
	}
	
}
