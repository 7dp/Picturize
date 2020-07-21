//
//  ProfileVC.swift
//  Picturize
//
//  Created by Crocodic on 15/07/20.
//  Copyright © 2020 WradDev. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
	@IBOutlet var emailLabel: UILabel!
	@IBOutlet var usernameLabel: UILabel!
	@IBOutlet var passwordLabel: UILabel!
	
	let viewModel = ProfileVM()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		setLabelText()
    }
	
	private func setLabelText() {
		emailLabel.text = viewModel.getEmail
		usernameLabel.text = "Username: " + viewModel.getUsername
		passwordLabel.text = "Password: " + viewModel.getPassword
	}

	@IBAction func logoutAction(_ sender: Any) {
		UserDefaults.standard.setLoggedOut()
		let loginController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
		loginController.modalPresentationStyle = .fullScreen
		self.present(loginController, animated: true, completion: {
			// Perhaps we'll doing something here later
		})
	}
}
