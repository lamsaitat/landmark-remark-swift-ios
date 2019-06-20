//
//  SignupViewControllerTests.swift
//  LandmarkRemarkTests
//
//  Created by Sai Tat Lam on 20/6/19.
//  Copyright © 2019 Sai Tat Lam. All rights reserved.
//

import XCTest
@testable import LandmarkRemark
@testable import Firebase

class SignupViewControllerTests: BaseTestCase {
    var vc: SignupViewController!
    
    override func setUp() {
        vc = createSignupViewController()
        vc.loadViewIfNeeded()
    }

    override func tearDown() {
        vc = nil
    }
    
    func testLoadView() {
        XCTAssertNotNil(vc)
        XCTAssertNotNil(vc.navigationController)
        XCTAssertNotNil(vc.view)
    }
    
    /**
     Test that the cancel button will dismiss the sign up view controller.
     Pre-requisite: Login view controller to present as window root.
     */
    func testCancelButtonTap() {
        let expectation = XCTestExpectation(description: "Waiting for sign up view controller to dismiss")
        let loginVc = createLoginViewController()
        loginVc.loadViewIfNeeded()
        UIApplication.shared.keyWindow?.rootViewController = loginVc
        
        loginVc.present(vc.navigationController!, animated: true) {
            guard let action = self.vc.cancelButtonItem.action, let target = self.vc.cancelButtonItem.target else {
                return XCTFail("Cancel button target or action not found")
            }

            UIApplication.shared.sendAction(action, to: target, from: self.vc, for: nil)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                expectation.fulfill()
            })
        }
        
        self.wait(for: [expectation], timeout: 10)
        XCTAssertNil(loginVc.presentedViewController)
        XCTAssertNil(vc.navigationController?.presentingViewController)
    }
    
    /**
     Test a successful sign up flow with all required fields filled.
     */
    func testSubmitButtonTapSuccessfulSignup() {
        let expectation = XCTestExpectation(description: "Waiting for sign up view controller to dismiss")
        let email = "testuser3@example.com"
        let password = "Th1s1sAWeakPassw0rd"
        let username = "testuser3"
        
        let loginVc = createLoginViewController()
        loginVc.loadViewIfNeeded()
        UIApplication.shared.keyWindow?.rootViewController = loginVc
        
        var resultingUser: Firebase.User!
        loginVc.present(vc.navigationController!, animated: true) {
            self.vc.emailTextField.text = email
            self.vc.passwordTextField.text = password
            self.vc.usernameTextField.text = username
            self.vc.submitButtonTouchUpInside(self.vc.submitButton)
            self.vc.signupCompletionBlock = { user in
                XCTAssertNotNil(user)
                resultingUser = user
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 30)
        XCTAssertEqual(resultingUser.email, email)
        XCTAssertEqual(resultingUser.displayName, username)
        
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
    
    /**
     Test that an empty field text will display border on the relevant field.
     */
    func testSubmitButtonTapEmptyUsername() {
        guard let vc = vc else {
            return XCTFail("SignupViewController instance not available for testing.")
        }
        UIApplication.shared.keyWindow?.rootViewController = vc.navigationController
        
        vc.submitButtonTouchUpInside(vc.submitButton)
        XCTAssertEqual(vc.usernameTextField.layer.borderWidth, 1.0, "Empty usernameTextField should highlight in red.")
        XCTAssertEqual(vc.usernameTextField.layer.borderColor, UIColor.red.cgColor, "Empty usernameTextField should highlight in red.")
        vc.usernameTextField.text = "A Temp User"
        vc.submitButtonTouchUpInside(vc.submitButton)
        XCTAssertEqual(vc.usernameTextField.layer.borderWidth, 0.0, "Valid usernameTextField should not highlight.")
        XCTAssertEqual(vc.usernameTextField.layer.borderColor, UIColor.clear.cgColor, "Valid usernameTextField should not highlight.")
        
        vc.submitButtonTouchUpInside(vc.submitButton)
        XCTAssertEqual(vc.emailTextField.layer.borderWidth, 1.0, "Empty email field should highlight in red.")
        XCTAssertEqual(vc.emailTextField.layer.borderColor, UIColor.red.cgColor, "Empty email field should highlight in red.")
        vc.emailTextField.text = "email@example.com"
        vc.submitButtonTouchUpInside(vc.submitButton)
        XCTAssertEqual(vc.emailTextField.layer.borderWidth, 0.0, "Valid email field should not highlight.")
        XCTAssertEqual(vc.emailTextField.layer.borderColor, UIColor.clear.cgColor, "Valid email field should not highlight.")
        
        vc.submitButtonTouchUpInside(vc.submitButton)
        XCTAssertEqual(vc.passwordTextField.layer.borderWidth, 1.0, "Empty passwordTextField should highlight in red.")
        XCTAssertEqual(vc.passwordTextField.layer.borderColor, UIColor.red.cgColor, "Empty passwordTextField should highlight in red.")
    }
    
    func testPresentSignupErrorAlert() {
        guard let vc = vc else {
            return XCTFail("SignupViewController instance not available for testing.")
        }
        UIApplication.shared.keyWindow?.rootViewController = vc.navigationController
        let error = NSError(domain: Bundle.main.bundleIdentifier!, code: 500, userInfo: [
            NSLocalizedDescriptionKey: "This is an error"
        ])
        let expectation = XCTestExpectation(description: "Wait for alert to present.")
        let alert = vc.presentSignupErrorAlert(with: error)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
        XCTAssertEqual(alert.presentingViewController, vc.navigationController)
        XCTAssertEqual(alert.title, "Sorry")
        XCTAssertEqual(alert.message, "Unable to complete sign up.\nError: This is an error")
    }
}
