//
//  LoginVC.swift
//  Picturize
//
//  Created by Crocodic on 13/07/20.
//  Copyright © 2020 WradDev. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
	@IBOutlet var loginBtn: UIButton!
	@IBOutlet var usernameField: UITextField!
	@IBOutlet var passwordField: UITextField!
	@IBOutlet var goToRegisterBtn: UIButton!
	
	let viewModel = LoginVM()
	
	var indicatorView: UIActivityIndicatorView?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		indicatorView = UIActivityIndicatorView.customIndicator(at: self.view.center)
		self.view.addSubview(indicatorView!)
		
		setupButton()
		
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
		view.addGestureRecognizer(tapGesture)
		
	}
	
	@objc func dismissKeyboard() {
		view.endEditing(true)
	}
	
	private func setupButton() {
		loginBtn.layer.cornerRadius = 8
	}
	
	@IBAction func signInAction(_ sender: Any) {
		self.indicatorView?.startAnimating()
		let username = usernameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
		let password = passwordField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
		let defaults = UserDefaults.standard
		
		if !username.isEmpty && !password.isEmpty && password.count >= 6 {
			
			if defaults.isSameData(username: username, password: password) {
				defaults.setLoggedIn()
				self.indicatorView?.stopAnimating()
				
				// Show the main screen
				let rootVC = UIApplication.shared.keyWindow?.rootViewController
				guard let mainNavigationController = rootVC as? MainNavigationContoller else { return }
				let mainController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainVC") as! MainVC
				mainNavigationController.viewControllers = [mainController]
				
				self.dismiss(animated: true, completion: nil)
				
			} else {
				self.view.makeToast("No user with this data")
				self.indicatorView?.stopAnimating()
			}
		} else {
			self.view.makeToast("Please fill all data")
			self.indicatorView?.stopAnimating()
		}
	}
	
	@IBAction func goToRegisterAction(_ sender: Any) {
		let navigationController = UINavigationController()
				
		let registerController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RegisterVC") as! RegisterVC
		navigationController.viewControllers = [registerController]
		navigationController.modalPresentationStyle = .fullScreen
		navigationController.navigationBar.prefersLargeTitles = true
//		registerController.modalPresentationStyle = .fullScreen
		self.present(navigationController, animated: true, completion: {
			// Perhaps we'll doing something here
		})
	}
}
