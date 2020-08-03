//
//  WalkthroughContentVC.swift
//  Picturize
//
//  Created by Crocodic on 01/08/20.
//  Copyright © 2020 WradDev. All rights reserved.
//

import UIKit
import Sejima

class WalkthroughContentVC: UIViewController {
	@IBOutlet var imageView: UIImageView!
	@IBOutlet var header: MUHeader!
	@IBOutlet var iconImageView: UIImageView!
	
	private var image: UIImage?
	private var headerTitle: String = ""
	private var headerDetail: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
		
		let titleFont: UIFont = UIFont.systemFont(ofSize: 29, weight: .bold)
		let detailFont: UIFont = UIFont.systemFont(ofSize: 16, weight: .regular)
		header.titleFont = titleFont
		header.detailFont = detailFont
		header.textAlignment = .center
		
		header.title = headerTitle
		header.detail = headerDetail
		iconImageView.image = image
    }
	
	internal func setup(with image: UIImage, title: String, detail: String) {
		self.image = image
		self.headerTitle = title
		self.headerDetail = detail
	}

}
