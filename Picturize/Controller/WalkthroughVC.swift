//
//  WalkthroughVC.swift
//  Picturize
//
//  Created by Crocodic on 01/08/20.
//  Copyright © 2020 WradDev. All rights reserved.
//

import UIKit
import Sejima

class WalkthroughVC: UIViewController {
	@IBOutlet var horizontalPager: MUHorizontalPager!
	@IBOutlet var pageControl: MUPageControl!
	@IBOutlet var skipButton: MUButton!
	
	private let getStartedTitle = "REGISTER"
	private let skipTitle = "SKIP"
	
	override var prefersStatusBarHidden: Bool {
		return true
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

//		view.clipsToBounds = true
		
		addWalkthroughContents()
		horizontalPager.delegate = self
        horizontalPager.pageControl = pageControl
        skipButton.delegate = self
        skipButton.buttonBackgroundColor = .clear
		skipButton.titleFont = .systemFont(ofSize: 18, weight: .regular)
    }
	
	private func addWalkthroughContents() {
		let vcs = [
			contentView(with: UIImage(named: "celebrate")!, title: "Welcome to Picturize", detail: "Thanks for downloading Picturize.\nWe hope you like it. Enjoy!").view!,
			contentView(with: UIImage(named: "photos")!, title: "Quality Photos", detail: "Millions ton of hi-res photos that will amaze you").view!,
			contentView(with: UIImage(named: "videos")!, title: "Popular Videos", detail: "Most accessed videos by users around the world.\nSure, with hi-res too").view!,
			contentView(with: UIImage(named: "search_phone")!, title: "Searchable Contents", detail: "Get interact with our powerful and accurate search engine").view!,
		]
		horizontalPager.add(views: vcs, margin: horizontalPager.horizontalMargin)
	}
	
	private func contentView(with image: UIImage, title: String = "", detail: String = "") -> WalkthroughContentVC {
		let vc = UIStoryboard(name: "Walkthrough", bundle: nil).instantiateViewController(withIdentifier: "WalkthroughContentVC") as! WalkthroughContentVC
		vc.setup(with: image, title: title, detail: detail)
		return vc
	}

}

extension WalkthroughVC: MUHorizontalPagerDelegate {
	func didScroll(horizontalPager: MUHorizontalPager, to index: Int) {
		guard let numberOfPages = horizontalPager.pageControl?.numberOfPages else { return }
		skipButton.title = index == numberOfPages - 1 ? self.getStartedTitle : self.skipTitle
	}
}

extension WalkthroughVC: MUButtonDelegate {
	func didTap(button: MUButton) {
		let numberOfPages = horizontalPager.pageControl?.numberOfPages ?? 0
		if button.title == self.skipTitle { 
			self.horizontalPager.set(page: numberOfPages - 1, animated: true)
		} else {
			perform(#selector(showLoginController), with: self, afterDelay: 0)
			UserDefaults.standard.setAcceptedWalkthrough()
		}
	}
	
	@objc func showLoginController() {
		let navigationController = UINavigationController()
		let loginController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
		navigationController.viewControllers = [loginController]
		navigationController.modalPresentationStyle = .fullScreen
		navigationController.navigationBar.prefersLargeTitles = true
		self.present(navigationController, animated: true, completion: nil)
	}
}
