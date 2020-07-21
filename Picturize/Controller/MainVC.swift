//
//  MainVC.swift
//  Picturize
//
//  Created by Crocodic on 02/07/20.
//  Copyright © 2020 WradDev. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class MainVC: ButtonBarPagerTabStripViewController {
	@IBOutlet var shadowView: UIView!
	@IBOutlet var searchItemBtn: UIBarButtonItem!
	
	let searchController = UISearchController(searchResultsController: nil)
	
	override func viewDidLoad() {
		settings.style.selectedBarBackgroundColor = .black
		settings.style.selectedBarHeight = 3
		
		super.viewDidLoad()
		
		self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
		
		setupTabBar()
	}
	
	func setupTabBar() {
		settings.style.buttonBarBackgroundColor = .white
		settings.style.buttonBarItemBackgroundColor = .white
		settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 16)
		settings.style.buttonBarMinimumLineSpacing = 0
		settings.style.buttonBarItemTitleColor = .black
		settings.style.buttonBarItemsShouldFillAvailableWidth = true
		settings.style.buttonBarLeftContentInset = 0
		settings.style.buttonBarRightContentInset = 0

		changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
			
			guard changeCurrentIndex == true else {	return }
			oldCell?.label.textColor = .gray
			newCell?.label.textColor = .black
		}
		
		addShadow()
	}
	
	func addShadow() {
		shadowView.layer.borderWidth = 1.0
		shadowView.layer.borderColor = UIColor.clear.cgColor
		shadowView.layer.masksToBounds = true
		shadowView.layer.shadowColor = UIColor.gray.cgColor
		shadowView.layer.shadowOffset = CGSize(width: 0, height: 1.5)
		shadowView.layer.shadowRadius = 3
		shadowView.layer.shadowOpacity = 1.0
		shadowView.layer.masksToBounds = false
		shadowView.layer.shadowPath = UIBezierPath(roundedRect: shadowView.bounds, cornerRadius: 0).cgPath
		shadowView.layer.shouldRasterize = true
		shadowView.layer.rasterizationScale = UIScreen.main.scale
	}
	
	override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
		var controllers = [UIViewController]()
		
		if #available(iOS 13.0, *) {
			let photosVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "PhotosVC")
			let videosVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "VideosVC")
			controllers.append(photosVC)
			controllers.append(videosVC)
		} else {
			// Fallback on earlier versions
		}
		return controllers
	}
	
	@IBAction func goToSearch(_ sender: Any) {
		let storyboard = UIStoryboard(name: "Search", bundle: nil)
		let controller = storyboard.instantiateViewController(withIdentifier: "SearchVC") as! SearchVC
		self.navigationController?.pushViewController(controller, animated: true)
		
	}
	
	@IBAction func goToProfile(_ sender: Any) {
		let storyboard = UIStoryboard(name: "Profile", bundle: nil)
		let controller = storyboard.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
		self.navigationController?.pushViewController(controller, animated: true)
	}
}
