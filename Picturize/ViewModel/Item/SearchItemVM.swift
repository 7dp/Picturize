//
//  SearchItemVM.swift
//  Picturize
//
//  Created by Crocodic on 10/07/20.
//  Copyright © 2020 WradDev. All rights reserved.
//

import Foundation

class SearchItemVM {
	
	var videos: [Video]?
	var photos: [Photo]?
	var indexPath: IndexPath
	
	init(videos: [Video], indexPath: IndexPath) {
		self.videos = videos
		self.photos = nil
		self.indexPath = indexPath
	}
	
	init(photos: [Photo], indexPath: IndexPath) {
		self.photos = photos
		self.videos = nil
		self.indexPath = indexPath
	}
	
	var getVideoThumbnailUrl: URL {
		return URL(string: self.videos![indexPath.item].videoPictures?.first?.picture ?? "")!
	}
	
	var getImageUrl: URL {
		let url =  URL(string: self.photos![indexPath.item].src.medium)!
		return url
	}
	
}
