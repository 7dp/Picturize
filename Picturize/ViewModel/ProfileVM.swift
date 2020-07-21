//
//  ProfileVM.swift
//  Picturize
//
//  Created by Crocodic on 15/07/20.
//  Copyright © 2020 WradDev. All rights reserved.
//

import UIKit

class ProfileVM {
	
	var getUsername: String {
		return UserDefaults.standard.string(forKey: UserDefaultsKey.usernameKey)!
	}
	
	var getEmail: String {
		return UserDefaults.standard.string(forKey: UserDefaultsKey.emailKey)!
	}
	
	var getPassword: String {
		return UserDefaults.standard.string(forKey: UserDefaultsKey.passwordKey)!
	}
}
