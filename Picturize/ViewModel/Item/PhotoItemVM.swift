//
//  PhotoItemVM.swift
//  Picturize
//
//  Created by Crocodic on 03/07/20.
//  Copyright © 2020 WradDev. All rights reserved.
//

import Foundation

class PhotoItemVM {
	private var photos: [Photo]
	private var indexPath: IndexPath
	
	init(photos: [Photo], indexPath: IndexPath) {
		self.photos = photos
		self.indexPath = indexPath
	}
	
	var getImageUrl: URL {
		let url =  URL(string: self.photos[indexPath.item].src.medium)!
		return url
	}
}
