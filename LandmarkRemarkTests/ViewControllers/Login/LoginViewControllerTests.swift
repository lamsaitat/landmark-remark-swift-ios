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

class LoginViewControllerTests: BaseTestCase {
    var vc: LoginViewController!
    
    override func setUp() {
        vc = createLoginViewController()
        UIApplication.shared.keyWindow?.rootViewController = vc
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

    /**
     Test signup button tap should modally present the sign up view controller.
     */
    func testSignupButtonTap() {
        let expectation = XCTestExpectation(description: "Waiting for modal presentation.")
        vc.signupButton.sendActions(for: .touchUpInside)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 6.0)
        guard let navController = vc.presentedViewController as? UINavigationController else {
            return XCTFail("Expected LoginViewController to present a UINavigationController instance.")
        }
        
        XCTAssertNotNil(navController.viewControllers.first as? SignupViewController)
        let signupVc: SignupViewController! = navController.viewControllers.first as? SignupViewController
        XCTAssertNotNil(signupVc.signupCompletionBlock)
    }
    
    /**
     Test a successful login via performLogin method, expects a non-nil currentUser from Auth.
     */
    func testPerformLogin() {
        let expectation = XCTestExpectation(description: "Wait for login.")
        
        let email = "testuser1@example.com"
        let password = "Th1s1sAWeakPassw0rd"
        let auth = EmailAuthProvider.credential(withEmail: email, password: password)
        var resultingUser: Firebase.User?
        let handle = Auth.auth().addStateDidChangeListener { _, user in
            // The listener can fire at initialisation state.
            // If there is no successful login, this test case will time out.
            if let user = user {
                resultingUser = user
                expectation.fulfill()
            }
        }
        vc.performLogin(with: auth)
        wait(for: [expectation], timeout: 15.0)
        XCTAssertNotNil(resultingUser)
        XCTAssertEqual(resultingUser?.email, email)
        XCTAssertEqual(resultingUser?.displayName, "Test User No.1")
        
        // Clean up.
        Auth.auth().removeStateDidChangeListener(handle)
        try? Auth.auth().signOut()
    }
    
    /**
     Test that a valid login credential should properly login a user.
     */
    func testLoginButtonTappedWithSuccessfulLogin() {
        let expectation = XCTestExpectation(description: "Wait for login.")
        
        let email = "testuser1@example.com"
        let password = "Th1s1sAWeakPassw0rd"
        
        vc.emailTextField.text = email
        vc.passwordTextField.text = password
        var resultingUser: Firebase.User?
        let handle = Auth.auth().addStateDidChangeListener { _, user in
            // The listener can fire at initialisation state.
            // If there is no successful login, this test case will time out.
            if let user = user {
                resultingUser = user
                expectation.fulfill()
            }
        }
        vc.loginButtonTouchUpInside(vc.loginButton)
        wait(for: [expectation], timeout: 15.0)
        XCTAssertNotNil(resultingUser)
        XCTAssertEqual(resultingUser?.email, email)
        XCTAssertEqual(resultingUser?.displayName, "Test User No.1")
        
        // Clean up.
        Auth.auth().removeStateDidChangeListener(handle)
        try? Auth.auth().signOut()
    }
    
    /**
     Test that login attempt with empty fields should highlight the offending field.
     */
    func testLoginButtonWithMissingFields() {
        vc.loginButtonTouchUpInside(vc.loginButton)
        XCTAssertEqual(vc.emailTextField.layer.borderWidth, 1.0, "Empty emailTextField should highlight in red.")
        XCTAssertEqual(vc.emailTextField.layer.borderColor, UIColor.red.cgColor, "Empty emailTextField should highlight in red.")
        vc.emailTextField.text = "email@example.com"
        vc.loginButtonTouchUpInside(vc.loginButton)
        XCTAssertEqual(vc.emailTextField.layer.borderWidth, 0.0, "Valid emailTextField should not highlight.")
        XCTAssertEqual(vc.emailTextField.layer.borderColor, UIColor.clear.cgColor, "Valid emailTextField should not highlight.")
        
        XCTAssertEqual(vc.passwordTextField.layer.borderWidth, 1.0, "Empty passwordTextField should highlight in red.")
        XCTAssertEqual(vc.passwordTextField.layer.borderColor, UIColor.red.cgColor, "Empty passwordTextField should highlight in red.")
    }
    
    func testPresentLoginErrorAlert() {
        let error = NSError(domain: Bundle.main.bundleIdentifier!, code: 500, userInfo: [
            NSLocalizedDescriptionKey: "This is an error"
            ])
        let expectation = XCTestExpectation(description: "Wait for alert to present.")
        let alert = vc.presentLoginErrorAlert(with: error)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
        XCTAssertEqual(alert.presentingViewController, vc.navigationController)
        XCTAssertEqual(alert.title, "Sorry")
        XCTAssertEqual(alert.message, "Unable to login.\nError: This is an error")
    }
    
    /**
     On successful login the view controller should present the landmark view
     controller via a navigation controller.
     */
    func testSuccessfulLoginToPresentLandmarkNavController() {
        guard let vc = vc else {
            return XCTFail("LoginViewController instance not available for testing.")
        }
        let loginExpectation = XCTestExpectation(description: "Wait for login.")
        let presentExpectation = XCTestExpectation(description: "Wait for modal presentation.")
        let email = "testuser1@example.com"
        let password = "Th1s1sAWeakPassw0rd"
        
        vc.emailTextField.text = email
        vc.passwordTextField.text = password
        var resultingUser: Firebase.User?
        let handle = Auth.auth().addStateDidChangeListener { _, user in
            if let user = user {
                resultingUser = user
                loginExpectation.fulfill()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                    XCTAssertNotNil(vc.presentedViewController)
                    presentExpectation.fulfill()
                })
            }
        }
        vc.loginButtonTouchUpInside(vc.loginButton)
        wait(for: [loginExpectation, presentExpectation], timeout: 15.0, enforceOrder: true)
        XCTAssertNotNil(resultingUser)
        XCTAssertEqual(resultingUser?.email, email)
        XCTAssertEqual(resultingUser?.displayName, "Test User No.1")
        let navController = vc.presentedViewController as? UINavigationController
        XCTAssertNotNil(navController)
        
        // Clean up.
        Auth.auth().removeStateDidChangeListener(handle)
        try? Auth.auth().signOut()
    }
}
