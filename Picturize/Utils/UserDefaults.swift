//
//  UserDefaults.swift
//  Picturize
//
//  Created by Crocodic on 14/07/20.
//  Copyright © 2020 WradDev. All rights reserved.
//

import Foundation

extension UserDefaults {
	
	func registerUserData(id: String, username: String, email: String, password: String, confirmationPassword: String) {
		set(id, forKey: UserDefaultsKey.userIdKey)
		set(username, forKey: UserDefaultsKey.usernameKey)
		set(email, forKey: UserDefaultsKey.emailKey)
		set(password, forKey: UserDefaultsKey.passwordKey)
		set(confirmationPassword, forKey: UserDefaultsKey.confirmPasswordKey)
		set(false, forKey: UserDefaultsKey.isLoggedInKey)
		synchronize()
	}
	
	func setLoggedIn() {
		set(true, forKey: UserDefaultsKey.isLoggedInKey)
		synchronize()
	}
	
	var isLoggedIn: Bool {
		return self.bool(forKey: UserDefaultsKey.isLoggedInKey)
	}
	
	func isSameData(username: String, password: String) -> Bool {
		guard let usernameDefault = self.string(forKey: UserDefaultsKey.usernameKey) else { return false }
		guard let passwordDefault = self.string(forKey: UserDefaultsKey.passwordKey) else { return false }
		
		return usernameDefault.elementsEqual(username) && passwordDefault.elementsEqual(password)
	}
	
	func setLoggedOut() {
		set("", forKey: UserDefaultsKey.userIdKey)
		set("", forKey: UserDefaultsKey.usernameKey)
		set("", forKey: UserDefaultsKey.emailKey)
		set("", forKey: UserDefaultsKey.passwordKey)
		set("", forKey: UserDefaultsKey.confirmPasswordKey)
		set(false, forKey: UserDefaultsKey.isLoggedInKey)
		synchronize()
	}
	
	
}
