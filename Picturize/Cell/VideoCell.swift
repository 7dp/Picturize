//
//  VideoCell.swift
//  Picturize
//
//  Created by Crocodic on 04/07/20.
//  Copyright © 2020 WradDev. All rights reserved.
//

import UIKit

class VideoCell: UICollectionViewCell {
	@IBOutlet var imageView: UIImageView!
	@IBOutlet var playImageView: UIImageView!
	@IBOutlet var blackOverlayView: UIView!
	
	var viewModel: VideoItemVM! {
		didSet {
			blackOverlayView.layer.cornerRadius = 10
			imageView.layer.cornerRadius = 10
			imageView.sd_setImage(with: viewModel.getVideoThumbnailUrl)
		}
	}
	
	override class func awakeFromNib() {
		super.awakeFromNib()
	}
	
}
