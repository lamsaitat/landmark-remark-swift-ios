//
//  LoginViewModel.swift
//  LandmarkRemark
//
//  Created by Sai Tat Lam on 20/6/19.
//  Copyright © 2019 Sai Tat Lam. All rights reserved.
//

import Foundation
import Firebase

class LoginViewModel {
    
    func performLogin(withCredential auth: AuthCredential, completion: ((Firebase.User?, Error?) -> Void)?) {
        Auth.auth().signIn(with: auth) { (result, error) in
            completion?(result?.user, error)
        }
    }
    
    func performLogin(withEmail email: String, password: String, completion: ((Firebase.User?, Error?) -> Void)?) {
        let auth = EmailAuthProvider.credential(withEmail: email, password: password)
        performLogin(withCredential: auth, completion: completion)
    }
}
