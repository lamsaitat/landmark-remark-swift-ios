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
    
    var signupCompletionBlock: ((Firebase.User?, Firebase.AuthCredential) -> Void)?
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
            usernameTextField.becomeFirstResponder()
            return
        }
        usernameTextField.markAsValid()
        guard let email = emailTextField.text, email.count > 0 else {
            emailTextField.markAsInvalid()
            emailTextField.becomeFirstResponder()
            return
        }
        emailTextField.markAsValid()
        guard let password = passwordTextField.text, password.count > 0 else {
            passwordTextField.markAsInvalid()
            passwordTextField.becomeFirstResponder()
            return
        }
        passwordTextField.markAsValid()
        
        usernameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        let alert = presentLoadingAlert(withTitle: "Signing up now...", subTitle: nil)
        viewModel.performSignup(withEmail: email, password: password, username: username) { [weak self] (user, error) in
            guard let self = self else {
                return
            }
            DispatchQueue.main.async {
                alert.dismiss(animated: false, completion: nil)
            }
            if let error = error {
                DispatchQueue.main.async {
                    _ = self.presentSignupErrorAlert(with: error)
                }
                return
            }
            if let user = user, let completion = self.signupCompletionBlock {
                let auth = EmailAuthProvider.credential(withEmail: email, password: password)
                completion(user, auth)
            }
        }
    }
}


// MARK: - Private method

extension SignupViewController {
    func presentSignupErrorAlert(with error: Error) -> UIAlertController {
        let alert = UIAlertController(title: "Sorry", message: "Unable to complete sign up.\nError: \(error.localizedDescription)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .destructive, handler: nil))
        present(alert, animated: true, completion: nil)
        return alert
    }
}
