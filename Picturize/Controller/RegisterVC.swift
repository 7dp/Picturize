//
//  RegisterVC.swift
//  Picturize
//
//  Created by Crocodic on 06/07/20.
//  Copyright © 2020 WradDev. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController {
	@IBOutlet var registerBtn: UIButton!
	@IBOutlet var usernameTextField: UITextField!
	@IBOutlet var emailTextField: UITextField!
	@IBOutlet var passwordTextField: UITextField!
	@IBOutlet var confirmPasswordTextField: UITextField!
	@IBOutlet var goToLoginBtn: UIButton!
	
	let viewModel = RegisterVM()
	
    override func viewDidLoad() {
        super.viewDidLoad()

		customizeButton()
		
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
		view.addGestureRecognizer(tapGesture)
    }
	
	@objc func dismissKeyboard() {
		view.endEditing(true)
	}
	
	private func customizeButton() {
		registerBtn.layer.cornerRadius = 8
	}
	
	@IBAction func signUpAction(_ sender: Any) {
		let username = usernameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
		let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
		let pswd = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
		let confirmPswd = confirmPasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
		
		let isValid = self.viewModel.isValid(username: username, email: email, pswd: pswd, confirmPswd: confirmPswd)
		
		if isValid.0 {
			viewModel.registerNewUserData()
			self.dismiss(animated: true, completion: nil)
		} else {
			self.view.makeToast(isValid.1)
		}
	}
	
	@IBAction func goToLoginAction(_ sender: Any) {
		self.dismiss(animated: true, completion: nil)
		let loginController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
		loginController.modalPresentationStyle = .fullScreen
		self.present(loginController, animated: true, completion: {
			// Perhaps we'll doing something here later
		})
		
	}
	
}
