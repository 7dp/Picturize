//
//  Videos.swift
//  Picturize
//
//  Created by Crocodic on 04/07/20.
//  Copyright © 2020 WradDev. All rights reserved.
//

import Foundation

struct Videos: Decodable {
	let page: Int
	let perPage: Int
	let totalResults: Int
    let url: String?
    let videos: [Video]

    enum CodingKeys: String, CodingKey {
        case page = "page"
        case perPage = "per_page"
        case totalResults = "total_results"
        case url = "url"
		case videos = "videos"
    }
}

struct Video: Decodable {
	let id: Int
	let width: Int
	let height: Int
	let url: String
	let image: String
	let duration: Int
	let user: User?
	let videoFiles: [VideoFile]?
	let videoPictures: [VideoPicture]?
	
	enum CodingKeys: String, CodingKey {
		case id = "id"
		case width = "width"
		case height = "height"
		case url = "url"
		case image = "image"
		case duration = "duration"
		case user = "user"
        case videoFiles = "video_files"
        case videoPictures = "video_pictures"
    }
}

struct User: Decodable {
    let id: Int
    let name: String
    let url: String
	
	enum CodingKeys: String, CodingKey {
		case id = "id"
		case name = "name"
		case url = "url"
	}
}

struct VideoFile: Decodable {
    let id: Int
    let quality: Quality?
    let fileType: FileType?
	let width: Int?
	let height: Int?
    let link: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
		case quality = "quality"
        case fileType = "file_type"
        case width = "width"
		case height = "height"
		case link = "link"
    }
}

enum FileType: String, Decodable {
    case videoMp4 = "video/mp4"
}

enum Quality: String, Decodable {
    case hd = "hd"
    case hls = "hls"
    case sd = "sd"
	case mobile = "mobile"
}

struct VideoPicture: Decodable {
    let id: Int
    let picture: String?
    let nr: Int
	
	enum CodingKeys: String, CodingKey {
		case id = "id"
		case picture = "picture"
		case nr = "nr"
	}
}

/* MARK: JSON Data

{
"page": 1,
"per_page": 15,
"total_results": 23624,
"url": "https://www.pexels.com/videos/",
"videos": [
	{
		"full_res": null,
		"tags": [],
		"id": 3363557,
		"width": 1920,
		"height": 1080,
		"url": "https://www.pexels.com/video/a-couple-in-a-passionate-expression-of-love-3363557/",
		"image": "https://images.pexels.com/videos/3363557/free-video-3363557.jpg?fit=crop&w=1200&h=630&auto=compress&cs=tinysrgb",
		"duration": 27,
		"user": {
			"id": 801145,
			"name": "Lay-Z Owl",
			"url": "https://www.pexels.com/@lay-z-owl-801145"
		},
		"video_files": [
			{
				"id": 322188,
				"quality": "hd",
				"file_type": "video/mp4",
				"width": 1920,
				"height": 1080,
				"link": "https://player.vimeo.com/external/378622664.hd.mp4?s=57281c6d638ceac4b475383d2a75e9cc1808b483&profile_id=175&oauth2_token_id=57447761"
			},
			[...]
		],
		"video_pictures": [
			{
				"id": 727195,
				"picture": "https://images.pexels.com/videos/3363557/pictures/preview-0.jpg",
				"nr": 0
			},
			[...]
		]
	},
	[...]
]
}
*/
