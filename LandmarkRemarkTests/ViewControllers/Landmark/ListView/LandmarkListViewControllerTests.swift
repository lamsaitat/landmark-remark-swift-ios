//
//  LandmarkListViewControllerTests.swift
//  LandmarkRemarkTests
//
//  Created by Sai Tat Lam on 22/6/19.
//  Copyright © 2019 Sai Tat Lam. All rights reserved.
//

import XCTest
@testable import LandmarkRemark

class LandmarkListViewControllerTests: BaseTestCase {
    var vc: LandmarkListViewController!
    
    override func setUp() {
        vc = createLandmarkListViewController()
        vc.loadViewIfNeeded()
    }

    override func tearDown() {
        vc = nil
    }
    
    func testLoadView() {
        XCTAssertNotNil(vc)
        XCTAssertNotNil(vc.tableView)
    }
}
