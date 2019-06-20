//
//  SignupViewController.swift
//  LandmarkRemark
//
//  Created by Sai Tat Lam on 20/6/19.
//  Copyright © 2019 Sai Tat Lam. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {
    
    @IBOutlet weak var cancelButtonItem: UIBarButtonItem!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    var signupCompletionBlock: (() -> Void)?
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

    }
}
