//
//  SignupViewController.swift
//  LandmarkRemark
//
//  Created by Sai Tat Lam on 20/6/19.
//  Copyright © 2019 Sai Tat Lam. All rights reserved.
//

import UIKit
import Firebase

class SignupViewController: UIViewController {
    
    @IBOutlet weak var cancelButtonItem: UIBarButtonItem!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    var signupCompletionBlock: ((Firebase.User?) -> Void)?
    let viewModel = SignupViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        submitButton.layer.cornerRadius = 5.0
    }
}


// MARK: - IBActions
extension SignupViewController {
    @IBAction func cancelButtonItemTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submitButtonTouchUpInside(_ sender: UIButton) {
        guard let username = usernameTextField.text, username.count > 0 else {
            usernameTextField.markAsInvalid()
            return
        }
        usernameTextField.markAsValid()
        guard let email = emailTextField.text, email.count > 0 else {
            emailTextField.markAsInvalid()
            return
        }
        emailTextField.markAsValid()
        guard let password = passwordTextField.text, password.count > 0 else {
            passwordTextField.markAsInvalid()
            return
        }
        passwordTextField.markAsValid()
        
        viewModel.performSignup(withEmail: email, password: password, username: username) { [weak self] (user, error) in
            guard let self = self else {
                return
            }
            if let error = error {
                debugPrint("Error with signup: \(error.localizedDescription)")
                return
            }
            if let user = user, let completion = self.signupCompletionBlock {
                completion(user)
            }
        }
    }
}
