//
//  Extension.swift
//  vipaji
//
//  Created by Mickey on 1/28/18.
//  Copyright © 2018 Mickey. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

extension UIView {
    /// Add a background layer consisting of a predefined vertical blue gradient
    func addGradientBackground() {
        DispatchQueue.global(qos: .background).async {
            let lightBlue = UIColor(red: 0.4, green: 0.57, blue: 0.94, alpha: 1.0).cgColor
            let darkBlue = UIColor(red: 0.13, green: 0.28, blue: 0.94, alpha: 1.0).cgColor
            
            DispatchQueue.main.async {
                let gradientLayer = CAGradientLayer()
                gradientLayer.colors = [lightBlue, darkBlue]
                gradientLayer.frame = self.bounds
                
                self.layer.insertSublayer(gradientLayer, at: 0)
                self.layoutSubviews()
            }
        }
    }
}

extension UIApplication {
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
}
