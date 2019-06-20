//
//  LoginViewController.swift
//  LandmarkRemark
//
//  Created by Sai Tat Lam on 19/6/19.
//  Copyright © 2019 Sai Tat Lam. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        loginButton.layer.cornerRadius = 5.0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let navController = segue.destination as? UINavigationController, let vc = navController.viewControllers.first as? SignupViewController {
            vc.signupCompletionBlock = { [weak self] user, auth in
                // TODO: Perform login with AuthCredential.
            }
        }
    }
}
