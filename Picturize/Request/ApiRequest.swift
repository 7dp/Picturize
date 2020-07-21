//
//  ApiRequest.swift
//  Picturize
//
//  Created by Crocodic on 03/07/20.
//  Copyright © 2020 WradDev. All rights reserved.
//

import Foundation
import Alamofire

class ApiRequest {

	static let photosBaseUrl = "https://api.pexels.com/v1"
	static let videosBaseUrl = "https://api.pexels.com/videos"
	static let headers: HTTPHeaders =
		["Authorization" : "563492ad6f917000010000017878c50c81e54693918599a19f15873e"]
}
