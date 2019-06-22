//
//  ComposeNewNoteViewControllerTests.swift
//  LandmarkRemarkTests
//
//  Created by Sai Tat Lam on 21/6/19.
//  Copyright © 2019 Sai Tat Lam. All rights reserved.
//

import XCTest
@testable import LandmarkRemark
@testable import Firebase

class ComposeNewNoteViewControllerTests: BaseTestCase {
    var vc: ComposeNewNoteViewController!
    
    override func setUp() {
        vc = createComposeNewNoteViewController()
        vc.coordinate = wynyardCoord
        vc.loadViewIfNeeded()
    }

    override func tearDown() {
        vc = nil
    }

    func testLoadView() {
        XCTAssertNotNil(vc.view)
        XCTAssertNotNil(vc.textView)
        XCTAssertNotNil(vc.postButtonItem)
    }
    
    func testLoadViewWithLocationSupplied() {
        guard let vc = vc else {
            return XCTFail("ComposeNewNoteViewController not available to run the test.")
        }
        UIApplication.shared.keyWindow?.rootViewController = vc.navigationController
        
        let expectation = XCTestExpectation(description: "Waiting for alert to present")
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
        XCTAssertNotNil(vc.coordinate)
        XCTAssertNotNil(vc.viewModel)
        XCTAssertNil(vc.presentedViewController)
    }
    
    func testLoadViewWithoutLocationShouldDisplayAlert() {
        vc = createComposeNewNoteViewController()
        vc.loadViewIfNeeded()
        UIApplication.shared.keyWindow?.rootViewController = vc.navigationController
        
        let expectation = XCTestExpectation(description: "Waiting for alert to present")
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
        
        let alert = vc.presentedViewController as? UIAlertController
        XCTAssertNotNil(alert)
        XCTAssertEqual(alert?.title, "Unable to publish note")
        XCTAssertEqual(alert?.message, "Current location is not available.")
        XCTAssertNotNil(alert?.actions.first)
        XCTAssertEqual(alert?.actions.first?.title, "Dismiss")
    }
    
    func testPresentLocationUnavailableAlert() {
        guard let vc = vc else {
            return XCTFail("ComposeNewNoteViewController not available to run test.")
        }
        UIApplication.shared.keyWindow?.rootViewController = vc.navigationController
        let expectation = XCTestExpectation(description: "Waiting for alert to display.")
        let alert = vc.presentLocationUnavailableAlert()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
        XCTAssertNotNil(alert.presentingViewController)
        XCTAssertEqual(alert.title, "Unable to publish note")
        XCTAssertEqual(alert.message, "Current location is not available.")
        XCTAssertNotNil(alert.actions.first)
        XCTAssertEqual(alert.actions.first?.title, "Dismiss")
    }
    
    func testPresentErrorAlert() {
        guard let vc = vc else {
            return XCTFail("ComposeNewNoteViewController not available to run test.")
        }
        UIApplication.shared.keyWindow?.rootViewController = vc.navigationController
        let expectation = XCTestExpectation(description: "Waiting for alert to display.")
        
        let error = NSError(domain: Bundle.main.bundleIdentifier!, code: 500, userInfo: [
            NSLocalizedDescriptionKey: "This is an error."
        ])
        let alert = vc.presentAlert(withError: error)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
        XCTAssertNotNil(alert.presentingViewController)
        XCTAssertEqual(alert.title, "Unable to publish note")
        XCTAssertEqual(alert.message, "Error: This is an error.")
        XCTAssertNotNil(alert.actions.first)
        XCTAssertEqual(alert.actions.first?.title, "Dismiss")
    }
    
    /**
     Test a successful publishing flow.
     The view controller method only reacts by no alert presenting and the vc
     itself is popped.
     */
    func testPublishButtonTappedSuccessfullyPublished() {
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
        
        // Step 2: Pushes a ComposeNewNoteViewController instance to the
        // LandmarkViewController's navigation stack.
        guard let vc = vc, let navController = vc.navigationController else {
            return XCTFail("ComposeNewNoteViewController not available to run test.")
        }
        let landmarkVc = createLandmarkViewController()
        guard let landmarkNavController = landmarkVc.navigationController else {
            return XCTFail("LandmarkViewController not available to run test.")
        }
        let message = "This is a test message for testPublishButtonTappedSuccessfullyPublished()"
        UIApplication.shared.keyWindow?.rootViewController = landmarkNavController
        landmarkNavController.pushViewController(vc, animated: false)
        let expectation = XCTestExpectation(description: "Waiting for publish to complete.")
        var resultingSnapshot: DataSnapshot!
        Database.database().reference(withPath: Note.databaseName).queryOrdered(byChild: "message").queryEqual(toValue: message).observe(.value) { snapshot in
            resultingSnapshot = snapshot
            // Adds a delay to allow for navigation animation.
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
                expectation.fulfill()
            })
        }
        vc.textView.text = message
        vc.postButtonTapped(vc.postButtonItem)
        wait(for: [expectation], timeout: 30.0)
        XCTAssertNotNil(resultingSnapshot)
        
        // Test the compose vc has been popped off the navigation stack.
        XCTAssertNotEqual(navController.topViewController, vc)

        // Clean up.
        for child in resultingSnapshot.children {
            if let child = child as? DataSnapshot {
                child.ref.removeValue()
            }
        }
        try? Auth.auth().signOut()
    }
}
