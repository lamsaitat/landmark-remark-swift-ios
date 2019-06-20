//
//  SignupViewModel.swift
//  LandmarkRemark
//
//  Created by Sai Tat Lam on 20/6/19.
//  Copyright © 2019 Sai Tat Lam. All rights reserved.
//

import Foundation
import Firebase

class SignupViewModel {
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
