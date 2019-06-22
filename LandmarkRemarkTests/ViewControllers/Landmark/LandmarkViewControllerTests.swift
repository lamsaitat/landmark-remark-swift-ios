//
//  LandmarkViewControllerTests.swift
//  LandmarkRemarkTests
//
//  Created by Sai Tat Lam on 21/6/19.
//  Copyright © 2019 Sai Tat Lam. All rights reserved.
//

import XCTest
@testable import LandmarkRemark
@testable import Firebase

class LandmarkViewControllerTests: BaseTestCase {
    var vc: LandmarkViewController!
    
    override func setUp() {
        super.setUp()
        vc = createLandmarkViewController()
        vc.loadViewIfNeeded()
    }
    
    override func tearDown() {
        super.tearDown()
        vc.dismiss(animated: false, completion: nil)
        vc = nil
    }
    
    /**
     Test that the logout button will dismiss the landmark view controller and return to login view.
     */
    func testLogoutButtonTapped() {
        guard let navController = vc.navigationController, let vc = vc else {
            return XCTFail("LandmarkViewController not available for testing.")
        }
        let expectation = XCTestExpectation(description: "Wait for modal dismiss")
        let loginVc = createLoginViewController()
        UIApplication.shared.keyWindow?.rootViewController = loginVc
        
        loginVc.present(navController, animated: true) {
            vc.logoutButtonItemTapped(vc.logoutButtonItem)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                expectation.fulfill()
            })
        }
        
        wait(for: [expectation], timeout: 10)
        XCTAssertNotEqual(UIApplication.shared.keyWindow?.rootViewController, vc.navigationController)
        XCTAssertNotNil(UIApplication.shared.keyWindow?.rootViewController as? LoginViewController)
        XCTAssertNil(Auth.auth().currentUser)
    }
    
    func testSwitchingContentView() {
        guard let navController = vc.navigationController, let vc = vc else {
            return XCTFail("LandmarkViewController not available for testing.")
        }
        
        UIApplication.shared.keyWindow?.rootViewController = navController
        
        // Switch to listView (1)
        XCTAssertNil(vc.listViewController)
        vc.contentViewSegmentedControl.selectedSegmentIndex = 1
        vc.contentViewSegmentedControlValueChanged(vc.contentViewSegmentedControl)
        XCTAssertNotNil(vc.listViewController)
        XCTAssertEqual(vc.contentView, vc.listViewController.view.superview)
        XCTAssertTrue(vc.children.contains(vc.listViewController))
        XCTAssertFalse(vc.children.contains(vc.mapViewController))
        
        // Switch back to mapView (0)
        vc.contentViewSegmentedControl.selectedSegmentIndex = 0
        vc.contentViewSegmentedControlValueChanged(vc.contentViewSegmentedControl)
        XCTAssertNotNil(vc.mapViewController)
        XCTAssertEqual(vc.contentView, vc.mapViewController.view.superview)
        XCTAssertTrue(vc.children.contains(vc.mapViewController))
        XCTAssertFalse(vc.children.contains(vc.listViewController))
    }
}
