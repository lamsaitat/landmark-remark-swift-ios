//
//  UITextField+extensions.swift
//  LandmarkRemark
//
//  Created by Sai Tat Lam on 20/6/19.
//  Copyright © 2019 Sai Tat Lam. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    func markAsInvalid() {
        layer.borderWidth = 1.0
        layer.cornerRadius = 5.0
        layer.borderColor = UIColor.red.cgColor
    }
    
    func markAsValid() {
        layer.borderWidth = 0
        layer.cornerRadius = 0
        layer.borderColor = UIColor.clear.cgColor
    }
}
