//
//  PhotoCell.swift
//  Picturize
//
//  Created by Crocodic on 03/07/20.
//  Copyright © 2020 WradDev. All rights reserved.
//

import UIKit
import SDWebImage

class PhotoCell: UICollectionViewCell {
	@IBOutlet var imageView: UIImageView!
	
	var viewModel: PhotoItemVM! {
		didSet {
			imageView.sd_setImage(with: viewModel.getImageUrl)
			imageView.layer.cornerRadius = 10
		}
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
	}
	
}
