//
//  BaseTestCase.swift
//  LandmarkRemarkTests
//
//  Created by Sai Tat Lam on 20/6/19.
//  Copyright © 2019 Sai Tat Lam. All rights reserved.
//

import XCTest
@testable import LandmarkRemark

class BaseTestCase: XCTestCase {
    var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    func createLoginViewController() -> LoginViewController {
        guard let vc = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else {
            fatalError("Unable to instantiate LoginViewController from storyboard.")
        }
        return vc
    }
    
    func createSignupViewController() -> SignupViewController {
        guard let navController = mainStoryboard.instantiateViewController(withIdentifier: "SignupNavController") as? UINavigationController, let vc = navController.viewControllers.first as? SignupViewController else {
            fatalError("Unable to create SignupNavController from storyboard.")
        }
        return vc
    }
    
    func createLandmarkViewController() -> LandmarkViewController {
        guard let navController = mainStoryboard.instantiateViewController(withIdentifier: "LandmarkNavController") as? UINavigationController, let vc = navController.viewControllers.first as? LandmarkViewController else {
            fatalError("Unable to create LandmarkViewController from storyboard.")
        }
        return vc
    }
    
    func createLandmarkMapViewController() -> LandmarkMapViewController {
        guard let vc = mainStoryboard.instantiateViewController(withIdentifier: "LandmarkMapViewController") as? LandmarkMapViewController else {
            fatalError("Unable to create LandmarkMapViewController from storyboard.")
        }
        return vc
    }
    
    func createComposeNewNoteViewController() -> ComposeNewNoteViewController {
        guard let vc = mainStoryboard.instantiateViewController(withIdentifier: "ComposeNewNoteViewController") as? ComposeNewNoteViewController else {
            fatalError("Unable to create ComposeNewNoteViewController from storyboard.")
        }
        _ = UINavigationController(rootViewController: vc)
        return vc
    }
}
