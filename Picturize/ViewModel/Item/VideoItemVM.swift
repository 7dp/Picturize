//
//  VideoItemVM.swift
//  Picturize
//
//  Created by Crocodic on 04/07/20.
//  Copyright © 2020 WradDev. All rights reserved.
//

import Foundation

class VideoItemVM {
	private var videos: [Video]
	private var indexPath: IndexPath
	
	init(videos: [Video], indexPath: IndexPath) {
		self.videos = videos
		self.indexPath = indexPath
	}
	
	var getVideoThumbnailUrl: URL {
		return URL(string: videos[indexPath.item].videoPictures?.first?.picture ?? "")!
	}
	
}
