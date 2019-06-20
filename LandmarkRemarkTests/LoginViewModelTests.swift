//
//  LoginViewModelTests.swift
//  LandmarkRemarkTests
//
//  Created by Sai Tat Lam on 20/6/19.
//  Copyright © 2019 Sai Tat Lam. All rights reserved.
//

import XCTest
@testable import LandmarkRemark
@testable import Firebase

class LoginViewModelTests: XCTestCase {
    var vm: LoginViewModel!
    override func setUp() {
        vm = LoginViewModel()
    }

    override func tearDown() {
        vm = nil
    }
    
    func testPerformLogin() {
        let expectation = XCTestExpectation(description: "Waiting for login to return.")
        let email = "testuser1@example.com"
        let password = "Th1s1sAWeakPassw0rd"
        var resultingUser: Firebase.User!
        vm.performLogin(withEmail: email, password: password) { user, error in
            XCTAssertNil(error)
            XCTAssertNotNil(user)
            resultingUser = user
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 15.0)
        XCTAssertNotNil(resultingUser.uid)
        XCTAssertNotNil(resultingUser.email)
    }

    func testPerformSignup() {
        let expectation = XCTestExpectation(description: "Waiting for login to return.")
        let email = "testuser2@example.com"
        let password = "Th1s1sAWeakPassw0rd"
        let username = "testuser2"
        var resultingUser: Firebase.User!
        vm.performSignup(withEmail: email, password: password, username: username) { user, error in
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
        resultingUser.reauthenticate(with: cred) { _, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                XCTFail("Received error when reauthenticating user for deletion.")
            } else {
                resultingUser.delete(completion: { error in
                    if let error = error {
                        print("Error: \(error.localizedDescription)")
                        XCTFail("Received error when performing deletion of test user.")
                    } else {
                        cleanupExpectation.fulfill()
                    }
                })
            }
        }
        wait(for: [cleanupExpectation], timeout: 15.0)
    }
}
