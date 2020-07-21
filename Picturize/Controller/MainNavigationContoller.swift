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
		} else {
			perform(#selector(showLoginController), with: self, afterDelay: 0.01)
		}
	}
	
	@objc func showLoginController() {
		let navigationController = UINavigationController()
		let loginController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
//		loginController.modalPresentationStyle = .fullScreen
		navigationController.viewControllers = [loginController]
		navigationController.modalPresentationStyle = .fullScreen
		navigationController.navigationBar.prefersLargeTitles = true
		self.present(navigationController, animated: true, completion: {
			// Perhaps we'll doing something here later
		})
		
	}

}
