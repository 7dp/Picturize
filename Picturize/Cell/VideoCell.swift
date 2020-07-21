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
	
	var viewModel: VideoItemVM! {
		didSet {
			imageView.sd_setImage(with: viewModel.getVideoThumbnailUrl)
		}
	}
	
	override class func awakeFromNib() {
		super.awakeFromNib()
		
	}
	
}
