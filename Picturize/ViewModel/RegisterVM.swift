//
//  RegisterVM.swift
//  Picturize
//
//  Created by Crocodic on 13/07/20.
//  Copyright © 2020 WradDev. All rights reserved.
//

import Foundation

class RegisterVM {
	private var username = ""
	private var email = ""
	private var password = ""
	private var confirmationPassword = ""
	
	func isValid(username: String, email: String, pswd: String, confirmPswd: String) -> (Bool, String) {
		self.username = username
		self.email = email
		self.password = pswd
		self.confirmationPassword = confirmPswd
		
		if username.isEmpty {
			return (false, "Username is not valid")
		} else if email.isEmpty || !email.isValidEmail {
			return (false, "Email is not valid")
		} else if pswd.isEmpty || pswd.count <= 5 {
			return(false, "Password is not valid")
		} else if confirmPswd.isEmpty
			|| confirmPswd.count <= 5
			|| !confirmPswd.elementsEqual(pswd) {
			return(false, "Password confirmation is not valid")
		} else {
			return (true, "Success!")
		}
		
	}
	
	func registerNewUserData() {
		let defaults = UserDefaults.standard
		let id = UUID().uuidString
		defaults.registerUserData(id: id, username: username, email: email, password: password, confirmationPassword: confirmationPassword)
	}
	
}
