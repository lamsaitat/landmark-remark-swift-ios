//
//  ComposeNewNoteViewController.swift
//  LandmarkRemarkTests
//
//  Created by Sai Tat Lam on 21/6/19.
//  Copyright © 2019 Sai Tat Lam. All rights reserved.
//

import XCTest
@testable import LandmarkRemark

class ComposeNewNoteViewControllerTests: BaseTestCase {
    var vc: ComposeNewNoteViewController!
    
    override func setUp() {
        vc = createComposeNewNoteViewController()
        
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
}
