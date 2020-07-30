//
//  PlayerController.swift
//  Picturize
//
//  Created by Crocodic on 30/07/20.
//  Copyright © 2020 WradDev. All rights reserved.
//

import UIKit
import VersaPlayer

class PlayerController: UIViewController {
	@IBOutlet var playerView: VersaPlayerView!
	@IBOutlet var playerControls: VersaPlayerControls!
	
	var url: URL!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		playerView.use(controls: playerControls)
		let item = VersaPlayerItem(url: url)
		playerView.set(item: item)
	}
}
