//
//  LoginViewControllerTests.swift
//  LandmarkRemarkTests
//
//  Created by Sai Tat Lam on 19/6/19.
//  Copyright © 2019 Sai Tat Lam. All rights reserved.
//

import XCTest
@testable import LandmarkRemark
@testable import Firebase

class LoginViewControllerTests: XCTestCase {
    var vc: LoginViewController!
    
    override func setUp() {
        vc = createViewController()
        vc.loadViewIfNeeded()
    }

    override func tearDown() {
        vc = nil
    }

    func testLoadView() {
        XCTAssertNotNil(vc)
        
        XCTAssertNotNil(vc.emailTextField)
        XCTAssertNotNil(vc.passwordTextField)
        XCTAssertNotNil(vc.loginButton)
        XCTAssertNotNil(vc.signupButton)
    }

    
    func testPerformSignup() {
        let expectation = XCTestExpectation(description: "Waiting for login to return.")
        let email = "testuser2@example.com"
        let password = "Th1s1sAWeakPassw0rd"
        let username = "testuser2"
        var resultingUser: Firebase.User!
        vc.performSignup(withEmail: email, password: password, username: username) { user, error in
            
            XCTAssertNil(error)
            XCTAssertNotNil(user)
            resultingUser = user
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 15.0)
        XCTAssertNotNil(resultingUser.displayName)
        // Clean up by deleting.
        let cleanupExpectation = XCTestExpectation(description: "Waiting for user delete to return.")
        let cred = EmailAuthProvider.credential(withEmail: email, password: password)
        resultingUser.reauthenticate(with: cred) { (result, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                XCTFail()
            } else {
                resultingUser.delete(completion: { error in
                    if let error = error {
                        print("Error: \(error.localizedDescription)")
                        XCTFail()
                    } else {
                        cleanupExpectation.fulfill()
                    }
                })
            }
        }
        wait(for: [cleanupExpectation], timeout: 15.0)
    }
}


extension LoginViewControllerTests {
    func createViewController() -> LoginViewController {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else {
            fatalError("Unable to instantiate LoginViewController from storyboard.")
        }
        return vc
    }
}
