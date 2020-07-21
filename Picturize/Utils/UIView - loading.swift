//
//  ViewControl.swift
//  Picturize
//
//  Created by Crocodic on 08/07/20.
//  Copyright © 2020 WradDev. All rights reserved.
//

import UIKit

extension UIViewController {
    private static let association = ObjectAssociation<UIActivityIndicatorView>()
    
    var thisActivityIndicator: UIActivityIndicatorView {
        set { UIViewController.association[self] = newValue }
        get {
            if let indicator = UIViewController.association[self] {
                return indicator
            } else {
                UIViewController.association[self] = UIActivityIndicatorView.customIndicator(at: self.view.center)
                return UIViewController.association[self]!
            }
        }
    }
    
    // MARK: - Acitivity Indicator
    
    public func startIndicatingActivity() {
        DispatchQueue.main.async {
            self.view.addSubview(self.thisActivityIndicator)
            self.thisActivityIndicator.startAnimating()
        }
    }
    
    public func stopIndicatingActivity() {
        DispatchQueue.main.async {
            self.thisActivityIndicator.removeFromSuperview()
            self.thisActivityIndicator.stopAnimating()
        }
    }
}
