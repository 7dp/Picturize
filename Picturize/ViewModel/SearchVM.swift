//
//  SearchVM.swift
//  Picturize
//
//  Created by Crocodic on 09/07/20.
//  Copyright © 2020 WradDev. All rights reserved.
//

import Foundation
import Alamofire

class SearchVM {
	
	private var resultsPhotos = [Photo]()
	private var resultsVideos = [Video]()
	
	var page = 1
	var perPage = 20
	var videoTotalResults = 0
	private var isFetchingInProgress = false
	
	//MARK: - PHOTO
	func fetchPhotosByUserQuery(onSuccess: ((String) -> Void)?, onFailed: ((String) -> Void)?, forWhat query: String) {
		let url = ApiRequest.photosBaseUrl + "/search"
		let param : Parameters = ["query" : query, "per_page" : perPage, "page" : page]
		let headers = ApiRequest.headers
		
		print("IS PHOTOS FETCHING IN PROGRESS: ", isFetchingInProgress)
		
		guard !isFetchingInProgress else {
			print("isPhotosFetchingInProgress")
			return
		}
		isFetchingInProgress = true
		
		AF.request(url, parameters: param, headers: headers)
			.validate()
			.responseDecodable(of: Photos.self) { (response) in
				guard let photos = response.value else {
					onFailed?("#SEARCH PHOTOS -> Error: \(String(describing: response.error?.errorDescription))")
					self.isFetchingInProgress = false
					return
				}
				self.isFetchingInProgress = false
				if !photos.photos.isEmpty {
					if let totalResults = photos.totalResults {
						if totalResults > self.perPage {
							self.page += 1
						}
					}
					self.resultsPhotos.append(contentsOf: photos.photos)
					
					if photos.page > 1 {
						onSuccess?("#SEARCH PHOTOS -> Success!, page: \(photos.page)")
					} else {
						onSuccess?("#SEARCH PHOTOS -> Success!, page: \(photos.page)")
					}
				} else {
					onSuccess?("#SEARCH PHOTOS -> Success!, page: \(photos.page)")
				}
		}
	}
	
	func getSinglePhotoResult(indexPath: IndexPath) -> Photo {
		return resultsPhotos[indexPath.item]
	}
	
	var getPhotosResultsItemCount: Int {
		return self.resultsPhotos.count
	}
	
	var getPhotos: [Photo] {
		return self.resultsPhotos
	}
	
	func getPhotoItemViewModel(indexPath: IndexPath) -> PhotoItemVM {
		return PhotoItemVM(photos: self.resultsPhotos, indexPath: indexPath)
	}
	
	func resetList(position: Int) {
		self.page = 1
		if position == 0 {
			self.resultsPhotos.removeAll()
		} else {
			self.resultsVideos.removeAll()
		}
	}
	
	
	// MARK: - VIDEO
	func fetchVideosByUserQuery(onSuccess: ((String) -> Void)?, onFailed: ((String) -> Void)?, forWhat query: String) {
		let url = ApiRequest.videosBaseUrl + "/search"
		let param : Parameters = ["query" : query, "per_page" : perPage, "page" : page]
		let headers = ApiRequest.headers
		
		print("IS VIDEOS FETCHING IN PROGRESS: ", isFetchingInProgress)
		
		guard !isFetchingInProgress else {
			print("isVideosFetchingInProgress")
			return
		}
		self.isFetchingInProgress = true
		
		AF.request(url, parameters: param, headers: headers)
			.validate()
			.responseDecodable(of: Videos.self) { (response) in
				guard let videos = response.value else {
					onFailed?("#SEARCH VIDEOS -> Error:  \(String(describing: response.error?.errorDescription))")
					self.isFetchingInProgress = false
					return
				}
				self.isFetchingInProgress = false
				if !videos.videos.isEmpty {
					self.resultsVideos.append(contentsOf: videos.videos)
					self.videoTotalResults = videos.totalResults
					if videos.totalResults > self.perPage {
						self.page += 1
					}
					onSuccess?("#SEARCH VIDEOS -> Success!, page: \(videos.page)")
				} else {
					onSuccess?("#SEARCH VIDEOS -> Success!, page: \(videos.page)")
				}
		}
		
	}
	
	func getSingleVideoResult(indexPath: IndexPath) -> Video {
		return self.resultsVideos[indexPath.item]
	}
	
	var getVideosResultsItemCount: Int {
		return self.resultsVideos.count
	}
	
	var getVideos: [Video] {
		return self.resultsVideos
	}
	
	func getVideoItemViewModel(indexPath: IndexPath) -> VideoItemVM {
		return VideoItemVM(videos: self.resultsVideos, indexPath: indexPath)
	}
	
	func getItemViewModel(scopeState: Int, indexPath: IndexPath) -> SearchItemVM {
		if scopeState == 0 {
			return SearchItemVM(photos: self.resultsPhotos, indexPath: indexPath)
		} else {
			return SearchItemVM(videos: self.resultsVideos, indexPath: indexPath)
		}
	}
}

/* MARK: Error check on Decodable parse

do {
	_ = try JSONDecoder().decode(Videos.self, from: response.data!)
} catch let DecodingError.dataCorrupted(context) {
	print(context)
} catch let DecodingError.keyNotFound(key, context) {
	print("Key '\(key)' not found:", context.debugDescription)
	print("codingPath:", context.codingPath)
} catch let DecodingError.valueNotFound(value, context) {
	print("Value '\(value)' not found:", context.debugDescription)
	print("codingPath:", context.codingPath)
} catch let DecodingError.typeMismatch(type, context)  {
	print("Type '\(type)' mismatch:", context.debugDescription)
	print("codingPath:", context.codingPath)
} catch {
	print("error: ", error)
}

*/
