//
//  UIActivityIndicatorView - customIndicator.swift
//  Picturize
//
//  Created by Crocodic on 08/07/20.
//  Copyright © 2020 WradDev. All rights reserved.
//

import UIKit

extension UIActivityIndicatorView {
    public static func customIndicator(at center: CGPoint) -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        indicator.layer.cornerRadius = 0
        indicator.color = UIColor.black
        indicator.center = center
        indicator.backgroundColor = UIColor(red: 1/255, green: 1/255, blue: 1/255, alpha: 0.5)
        indicator.hidesWhenStopped = true
        return indicator
    }
}
