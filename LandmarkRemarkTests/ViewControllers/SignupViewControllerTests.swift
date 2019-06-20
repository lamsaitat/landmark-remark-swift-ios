//
//  SignupViewControllerTests.swift
//  LandmarkRemarkTests
//
//  Created by Sai Tat Lam on 20/6/19.
//  Copyright © 2019 Sai Tat Lam. All rights reserved.
//

import XCTest
@testable import LandmarkRemark

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
}
