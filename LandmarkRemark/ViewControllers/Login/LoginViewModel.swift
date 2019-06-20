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
    
    func performLogin(withEmail email: String, password: String, completion: ((Firebase.User?, Error?) -> Void)?) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            completion?(result?.user, error)
        }
    }
}
