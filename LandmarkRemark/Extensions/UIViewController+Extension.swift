//
//  UIViewController+Extension.swift
//  LandmarkRemark
//
//  Created by Sai Tat Lam on 23/6/19.
//  Copyright © 2019 Sai Tat Lam. All rights reserved.
//

import UIKit

extension UIViewController {
    /**
     Presents an alert with title and subtitle as a loading HUD.
     */
    func presentLoadingAlert(withTitle title: String?, subTitle subtitle: String?) -> UIAlertController {
        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        present(alert, animated: true, completion: nil)
        return alert
    }
}
