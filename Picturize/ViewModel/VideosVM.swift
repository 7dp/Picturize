//
//  VideosVM.swift
//  Picturize
//
//  Created by Crocodic on 04/07/20.
//  Copyright © 2020 WradDev. All rights reserved.
//

import Foundation
import Alamofire

class VideosVM {
	
	private var videoList = [Video]()
	
	private var page = 1
	private var isFetchingInProgress = false
	
	func fetchVideos(onSuccess: ((String, [IndexPath]?) -> Void)? , onFailed: ((String) -> Void)?) {
		let url = ApiRequest.videosBaseUrl + "/popular"
		let param: Parameters = ["per_page" : "20", "page": page]
		
		guard !isFetchingInProgress else { return }
		
		self.isFetchingInProgress = true
		
		AF.request(url, parameters: param, headers: ApiRequest.headers)
			.validate()
			.responseDecodable(of: Videos.self) { (response) in
				
				guard let videos = response.value else {
					onFailed?("#VIDEOS -> Error: \(String(describing: response.error?.errorDescription))")
					self.isFetchingInProgress = false
					return
				}
				if !videos.videos.isEmpty {
					self.isFetchingInProgress = false
					self.page += 1
					self.videoList.append(contentsOf: videos.videos)
					
					if videos.page > 1 {
						let indexPathsToReload = self.calculateindexPathsToReload(from: videos.videos)
						onSuccess?("#VIDEOS -> Success!", indexPathsToReload)
					} else {
						onSuccess?("#VIDEOS -> Success!", .none)
					}
				} else {
					onSuccess?("#VIDEOS -> Success!", .none)
				}
		}
	}
	
	private func calculateindexPathsToReload(from newVideos: [Video]) -> [IndexPath] {
		let startIndex = self.getVideosCount - newVideos.count
		let endIndex = startIndex + newVideos.count
		return (startIndex..<endIndex).map {
			IndexPath(item: $0, section: 0)
		}
	}
	
	func getItemViewModel(indexPath: IndexPath) -> VideoItemVM {
		return VideoItemVM(videos: self.videoList, indexPath: indexPath)
	}
	
	var getVideos: [Video] {
		return self.videoList
	}
	
	var getVideosCount: Int {
		return self.videoList.count
	}
	
	func getSingleVideo(indexPath: IndexPath) -> Video {
		return self.videoList[indexPath.item]
	}
	
}
