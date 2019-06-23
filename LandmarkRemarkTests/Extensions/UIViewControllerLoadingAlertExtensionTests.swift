//
//  UIViewControllerLoadingAlertExtensionTests.swift
//  LandmarkRemarkTests
//
//  Created by Sai Tat Lam on 23/6/19.
//  Copyright © 2019 Sai Tat Lam. All rights reserved.
//

import XCTest
@testable import LandmarkRemark

class UIViewControllerLoadingAlertExtensionTests: BaseTestCase {

    
    func testPresentLoadingAlert() {
        let vc = UIViewController()
        vc.loadViewIfNeeded()
        UIApplication.shared.keyWindow?.rootViewController = vc
        
        let expectation = XCTestExpectation(description: "Wait for alert to present.")
        let title = "Signing in..."
        let subtitle = "This should not take long."
        let alert = vc.presentLoadingAlert(withTitle: title, subTitle: subtitle)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
        XCTAssertNotNil(alert)
        XCTAssertNotNil(alert.presentingViewController)
        XCTAssertEqual(alert.presentingViewController, vc)
        XCTAssertEqual(alert, vc.presentedViewController)
    }
    
    func testPresentLoadingAlertWithNavigationController() {
        let vc = UIViewController()
        vc.loadViewIfNeeded()
        UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: vc)
        
        let expectation = XCTestExpectation(description: "Wait for alert to present.")
        let title = "Signing in..."
        let subtitle = "This should not take long."
        let alert = vc.presentLoadingAlert(withTitle: title, subTitle: subtitle)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
        XCTAssertNotNil(alert)
        XCTAssertNotNil(alert.presentingViewController)
        XCTAssertEqual(alert.presentingViewController, vc.navigationController)
        XCTAssertEqual(alert, vc.presentedViewController)
    }
}
