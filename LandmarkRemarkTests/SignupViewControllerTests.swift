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
}
