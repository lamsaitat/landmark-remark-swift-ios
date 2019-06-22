//
//  LandmarkListViewModelTests.swift
//  LandmarkRemarkTests
//
//  Created by Sai Tat Lam on 22/6/19.
//  Copyright © 2019 Sai Tat Lam. All rights reserved.
//

import XCTest
@testable import LandmarkRemark

class LandmarkListViewModelTests: BaseTestCase {
    var vm: LandmarkListViewModel!
    
    override func setUp() {
        vm = LandmarkListViewModel()
    }

    override func tearDown() {
        vm = nil
    }

    func testInstantiation() {
        XCTAssertNotNil(vm.notes)
    }

}
