//
//  PhotoObject.swift
//  Picturize
//
//  Created by Crocodic on 05/07/20.
//  Copyright © 2020 WradDev. All rights reserved.
//

import Foundation

struct SinglePhoto: Codable {
	let id: Int
	let width: Int
	let height: Int
	let url: String
	let photographer: String
	let photographerURL: String
	let photographerID: Int
	let src: SinglePhotoSrc
	let liked: Bool
	
	enum CodingKeys: String, CodingKey {
		case id = "case"
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

struct SinglePhotoSrc: Codable {
	let original: String
	let large2X: String
	let large: String
	let medium: String
	let small: String
	let portrait: String
	let landscape, tiny: String		// MARK: here
	
	enum CodingKeys: String, CodingKey {
		case original = "original"
		case large2X = "large2x"
		case large = "large"
		case medium = "medium"
		case small = "small"
		case portrait = "portrait"
		case landscape, tiny		 // MARK: here
	}
}

