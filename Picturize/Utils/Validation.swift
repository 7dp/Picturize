//
//  Validation.swift
//  Picturize
//
//  Created by Crocodic on 13/07/20.
//  Copyright © 2020 WradDev. All rights reserved.
//

import Foundation

extension String {
	var isValidEmail: Bool {
		let emailRegularExpression = "[A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+\\.[A-Z0-9a-z]{2,64}"
		let testEmail = NSPredicate(format: "SELF MATCHES %@", emailRegularExpression)
		return testEmail.evaluate(with: self)
	}
}
