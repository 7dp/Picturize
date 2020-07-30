//
//  SearchCell.swift
//  Picturize
//
//  Created by Crocodic on 10/07/20.
//  Copyright © 2020 WradDev. All rights reserved.
//

import UIKit
import SDWebImage

class SearchCell: UICollectionViewCell {
    
	@IBOutlet var imageView: UIImageView!
	@IBOutlet var playImageView: UIImageView!
	@IBOutlet var blackOverlayView: UIView!
	var scopePosition = 0
	
	var viewModel: SearchItemVM! {
		didSet {
			imageView.layer.cornerRadius = 10
			blackOverlayView.layer.cornerRadius = 10
			
			if scopePosition == 0 {
				playImageView.isHidden = true
				blackOverlayView.isHidden = true
				imageView.sd_setImage(with: viewModel.getImageUrl)
			} else {
				playImageView.isHidden = false
				blackOverlayView.isHidden = false
				imageView.sd_setImage(with: viewModel.getVideoThumbnailUrl)
			}
		}
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
	}
	
}
