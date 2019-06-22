//
//  NoteCellViewModelTests.swift
//  LandmarkRemarkTests
//
//  Created by Sai Tat Lam on 22/6/19.
//  Copyright © 2019 Sai Tat Lam. All rights reserved.
//

import XCTest
@testable import LandmarkRemark

class NoteCellViewModelTests: BaseTestCase {
    var vm: NoteCellViewModel!
    
    override func setUp() {
        vm = NoteCellViewModel(with: sampleNote)
    }

    override func tearDown() {
        vm = nil
    }

    func testMessageLabelDisplayString() {
        XCTAssertEqual(vm.messageLabelDisplayString, "This is a test message")
    }
    
    func testLocationLabelDisplayString() {
        XCTAssertEqual(vm.locationLabelDisplayString, "Location: (-33.8670864, 151.2077854)")
    }
    
    func testAuthorLabelDisplayString() {
        XCTAssertEqual(vm.authorLabelDisplayString, "Submitted by: TestUser-001")
    }
}
