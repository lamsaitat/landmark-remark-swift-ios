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
        let handle = Auth.auth().addStateDidChangeListener { (auth, user) in
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
}
