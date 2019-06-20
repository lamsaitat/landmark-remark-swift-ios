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
