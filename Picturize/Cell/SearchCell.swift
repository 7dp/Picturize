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
	var scopePosition = 0
	
	var viewModel: SearchItemVM! {
		didSet {
			if scopePosition == 0 {
				playImageView.isHidden = true
				imageView.sd_setImage(with: viewModel.getImageUrl)
			} else {
				playImageView.isHidden = false
				imageView.sd_setImage(with: viewModel.getVideoThumbnailUrl)
			}
		}
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
	}
	
}
