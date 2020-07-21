//
//  Photos.swift
//  Picturize
//
//  Created by Crocodic on 03/07/20.
//  Copyright © 2020 WradDev. All rights reserved.
//

import Foundation

struct Photos: Decodable {
	let page: Int
	let perPage: Int
	let photos: [Photo]
	let nextPage: String?
	let prevPage: String?
	let totalResults: Int?
	
	enum CodingKeys: String, CodingKey {
		case page = "page"
		case perPage = "per_page"
		case photos = "photos"
		case nextPage = "next_page"
		case prevPage = "prev_page"
		case totalResults = "total_results"
	}
}

struct Photo: Decodable {
	let id: Int
	let width: Int
	let height: Int
	let url: String
	let photographer: String
	let photographerURL: String
	let photographerID: Int
	let src: Src
	let liked: Bool
	
	enum CodingKeys: String, CodingKey {
		case id = "id"
		case width = "width"
		case height = "height"
		case url = "url"
		case photographer = "photographer"
		case photographerURL = "photographer_url"
		case photographerID = "photographer_id"
		case src = "src"
		case liked = "liked"
	}
}

struct Src: Decodable {
	let original: String
	let large2X: String
	let large: String
	let medium: String
	let small: String
	let portrait: String
	let landscape: String
	let tiny: String
	
	enum CodingKeys: String, CodingKey {
		case original = "original"
		case large2X = "large2x"
		case large = "large"
		case medium = "medium"
		case small = "small"
		case portrait = "portrait"
		case landscape = "landscape"
		case tiny = "tiny"
	}
}

/* MARK : JSON Data

{
    "page": 1,
    "per_page": 15,
    "photos": [
        {
            "id": 3150918,
            "width": 2736,
            "height": 3648,
            "url": "https://www.pexels.com/photo/black-and-brown-stairs-beside-window-3150918/",
            "photographer": "Octoptimist",
            "photographer_url": "https://www.pexels.com/@octoptimist",
            "photographer_id": 1436964,
            "src": {
                "original": "https://images.pexels.com/photos/3150918/pexels-photo-3150918.jpeg",
                "large2x": "https://images.pexels.com/photos/3150918/pexels-photo-3150918.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
                "large": "https://images.pexels.com/photos/3150918/pexels-photo-3150918.jpeg?auto=compress&cs=tinysrgb&h=650&w=940",
                "medium": "https://images.pexels.com/photos/3150918/pexels-photo-3150918.jpeg?auto=compress&cs=tinysrgb&h=350",
                "small": "https://images.pexels.com/photos/3150918/pexels-photo-3150918.jpeg?auto=compress&cs=tinysrgb&h=130",
                "portrait": "https://images.pexels.com/photos/3150918/pexels-photo-3150918.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=1200&w=800",
                "landscape": "https://images.pexels.com/photos/3150918/pexels-photo-3150918.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200",
                "tiny": "https://images.pexels.com/photos/3150918/pexels-photo-3150918.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280"
            },
            "liked": false
        }
],
    "next_page": "https://api.pexels.com/v1/curated/?page=2&per_page=15"
}
*/

