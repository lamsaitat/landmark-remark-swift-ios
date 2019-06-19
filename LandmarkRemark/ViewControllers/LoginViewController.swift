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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


// MARK: - Private methods
extension LoginViewController {
    
    func performSignup(withEmail email: String, password: String, username: String, completion: ((Firebase.User?, Error?) -> Void)?) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                completion?(nil, error)
            } else if let result = result {
                // Attach display name
                let user = result.user
                let request = user.createProfileChangeRequest()
                request.displayName = username
                
                request.commitChanges(completion: { (error) in
                    completion?(user, error)
                })
            } else {
                completion?(nil, NSError(domain: Bundle.main.bundleIdentifier!, code: 500, userInfo: [NSLocalizedDescriptionKey: "Unknown error"]))
            }
        }
    }
}
