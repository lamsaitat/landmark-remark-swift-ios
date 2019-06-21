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
    
    let viewModel = LoginViewModel()
    var stateDidChangeListenerHandle: AuthStateDidChangeListenerHandle?
    
    
    deinit {
        if let handle = stateDidChangeListenerHandle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stateDidChangeListenerHandle = Auth.auth().addStateDidChangeListener { (_, user) in
            debugPrint("User logged in: \(String(describing: user?.uid))")
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        loginButton.layer.cornerRadius = 5.0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let navController = segue.destination as? UINavigationController, let vc = navController.viewControllers.first as? SignupViewController {
            vc.signupCompletionBlock = { [weak self] (user: Firebase.User?, auth: Firebase.AuthCredential?) in
                guard let auth = auth else {
                    return
                }
                self?.performLogin(with: auth)
            }
        }
    }
}


// MARK: - IBActions
extension LoginViewController {
    @IBAction func loginButtonTouchUpInside(_ sender: UIButton) {
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

        performLogin(with: EmailAuthProvider.credential(withEmail: email, password: password))
    }
}


// MARK: - public methods
extension LoginViewController {
    func performLogin(with auth: AuthCredential) {
        viewModel.performLogin(withCredential: auth) { [weak self] _, error in
            if let error = error {
                _ = self?.presentLoginErrorAlert(with: error)
                return
            }
        }
    }
    
    func presentLoginErrorAlert(with error: Error) -> UIAlertController {
        let alert = UIAlertController(title: "Sorry", message: "Unable to login.\nError: \(error.localizedDescription)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .destructive, handler: nil))
        return alert
    }
}
