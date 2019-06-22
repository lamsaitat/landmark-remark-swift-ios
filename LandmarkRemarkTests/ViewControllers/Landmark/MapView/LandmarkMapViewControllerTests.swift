//
//  LandmarkMapViewControllerTests.swift
//  LandmarkRemarkTests
//
//  Created by Sai Tat Lam on 21/6/19.
//  Copyright © 2019 Sai Tat Lam. All rights reserved.
//

import XCTest
@testable import LandmarkRemark

class LandmarkMapViewControllerTests: BaseTestCase {
    var vc: LandmarkMapViewController!
    
    override func setUp() {
        vc = createLandmarkMapViewController()
        vc.loadViewIfNeeded()
    }

    override func tearDown() {
        vc = nil
    }

    func testLoadView() {
        XCTAssertNotNil(vc.mapView)
    }

}
