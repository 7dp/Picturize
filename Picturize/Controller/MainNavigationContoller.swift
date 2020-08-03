//
//  MainNavigationContoller.swift
//  Picturize
//
//  Created by Crocodic on 14/07/20.
//  Copyright © 2020 WradDev. All rights reserved.
//

import UIKit

class MainNavigationContoller: UINavigationController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		
		if UserDefaults.standard.isLoggedIn {
			let mainController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainVC") as! MainVC
			viewControllers = [mainController]
		} else if UserDefaults.standard.isAcceptedWalkthrough && !UserDefaults.standard.isLoggedIn {
			let blockerController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BlockerVC") as! BlockerVC
			viewControllers = [blockerController]
			perform(#selector(showLoginController), with: self, afterDelay: 0)
		} else {
			let blockerController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BlockerVC") as! BlockerVC
			viewControllers = [blockerController]
			perform(#selector(showWalkthroughController), with: self, afterDelay: 0)
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
	
	@objc func showWalkthroughController() {
		let navigationController = UINavigationController()
		let walkthroughController = UIStoryboard(name: "Walkthrough", bundle: nil).instantiateViewController(withIdentifier: "WalkthroughVC") as! WalkthroughVC
		navigationController.viewControllers = [walkthroughController]
		navigationController.modalPresentationStyle = .fullScreen
		navigationController.navigationBar.prefersLargeTitles = true
		self.present(navigationController, animated: true, completion: nil)
	}

}
