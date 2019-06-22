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
        // Sign out any pre-existing user.
        try? Auth.auth().signOut()
        
        // Step 1: Authenticate user for composing a note.
        let email = "testuser1@example.com"
        let password = "Th1s1sAWeakPassw0rd"
        let loginExpectation = XCTestExpectation(description: "Waiting for login to complete.")
        Auth.auth().signIn(withEmail: email, password: password) { (_, error) in
            if let error = error {
                return XCTFail("Unexpected error while logging in user: \(error.localizedDescription)")
            }
            loginExpectation.fulfill()
        }
        wait(for: [loginExpectation], timeout: 30.0)
        XCTAssertNotNil(Auth.auth().currentUser)
        UIApplication.shared.keyWindow?.rootViewController = navController
        
        // Arbitrarily introduces a delay to allow for the logout to complete.
        let logoutExpectation = XCTestExpectation(description: "Waiting for logout to complete.")
        vc.logoutButtonItemTapped(vc.logoutButtonItem)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            XCTAssertNil(Auth.auth().currentUser)
            logoutExpectation.fulfill()
        }
        wait(for: [logoutExpectation], timeout: 30.0)
        XCTAssertNotEqual(UIApplication.shared.keyWindow?.rootViewController, vc.navigationController)
        XCTAssertNotNil(UIApplication.shared.keyWindow?.rootViewController as? LoginViewController)
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
