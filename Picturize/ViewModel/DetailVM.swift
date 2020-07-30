//
//  DetailVM.swift
//  Picturize
//
//  Created by Crocodic on 07/07/20.
//  Copyright © 2020 WradDev. All rights reserved.
//

import Foundation
import Lightbox

class DetailVM {
	
	var photo: Photo?
	var video: Video?
	var image: UIImage!
	var isVideo: Bool!
	
	var getAuthor: String {
		if isVideo {
			return video?.user?.name ?? "-"
		} else {
			return photo?.photographer ?? "-"
		}
	}
	
	var getImageProvider: String {
		return "on Pexels"
	}
	
	var getURL: URL {
		if isVideo {
			return URL(string: self.video!.url)!
		} else {
			return URL(string: self.photo!.url)!
		}
	}
	
	var getImageURL: URL {
		if isVideo {
			return URL(string: self.video!.image)!
		} else {
			return URL(string: self.photo!.src.original)!
		}
	}
	
	var getAuthorURL: URL {
		if isVideo {
			return URL(string: self.video!.user?.url ?? "")!
		} else {
			return URL(string: photo!.photographerURL)!
		}
	}
	
	var getVideoURL: URL? {
		return URL(string: video?.videoFiles?.first?.link ?? "")
	}
	
	var getVideoResolution: String {
		if isVideo {
			return "\(self.video?.width ?? 0) x \(self.video?.height ?? 0)"
		}
		return ""
	}
	
	var getVideoDuration: String {
		if isVideo {
			let duration = self.video?.duration ?? 0
			var minutes = String(duration / 60)
			var seconds = String(duration % 60)
			
			if minutes.count == 1 {
				minutes = "0" + minutes
			}
			if seconds.count == 1 {
				seconds = "0" + seconds
			}
			return minutes + ":" + seconds
		}
		return ""
	}
	
	var getImage: UIImage? {
		return self.image
	}
	
	func setImage(image: UIImage) {
		self.image = image
	}
	
	var getLightboxImage: [LightboxImage] {
		var images: [LightboxImage] = []
		
		var newVideoUrl = self.getVideoURL
		if self.getVideoURL?.absoluteString != nil {
			var urlString = self.getVideoURL!.absoluteString
			if let targetRange = urlString.range(of: "?") {
				urlString.removeSubrange(targetRange.lowerBound..<urlString.endIndex)
			}
			newVideoUrl = URL(string: urlString)!
		}
//		let testUrl = URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")
//		let testUrl2 = URL(string: "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8")
		
		var image: LightboxImage
		if self.getImage == nil {
			image = LightboxImage(imageURL: self.getImageURL, text: self.getAuthor, videoURL: newVideoUrl)
		} else {
			image = LightboxImage(image: self.getImage!, text: self.getAuthor, videoURL: newVideoUrl)
		}
		images.append(image)
		return images
	}
	
	func download() {
		let titles = photo?.url.components(separatedBy: "/")
//		let title = titles?.index(before: titles!.count - 1)
		for title in titles! {
			print("TITLE:", title)
		}
		let key = "pexels_" + UUID().uuidString
		
		DispatchQueue.global(qos: .background).async {
			self.writeImageData(image: self.image, forKey: key)
		}
	}
	
	private func writeImageData(image: UIImage, forKey key: String) {
		if let pngData = image.pngData() {
			if let filePath = self.filePath(forkey: key) {
				do {
					try pngData.write(to: filePath, options: .atomic)
				} catch let error {
					print("SAVING RESULTS ERROR:", error)
				}
			}
		}
	}
	
	private func filePath(forkey key: String) -> URL? {
		let fileManager = FileManager.default
		guard let documentUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
		return documentUrl.appendingPathComponent(key + ".jpg")
	}
	
	
}
