//
//  ComposeNewNoteViewModelTests.swift
//  LandmarkRemarkTests
//
//  Created by Sai Tat Lam on 21/6/19.
//  Copyright © 2019 Sai Tat Lam. All rights reserved.
//

import XCTest
import CoreLocation
@testable import LandmarkRemark

class ComposeNewNoteViewModelTests: BaseTestCase {

    var vm: ComposeNewNoteViewModel!
    
    override func setUp() {
    }
    
    override func tearDown() {
        vm = nil
    }
    
    func testInstantiation() {
        vm = ComposeNewNoteViewModel(with: wynyardCoord)
        XCTAssertNotNil(vm)
        XCTAssertNotNil(vm.coordinate)
    }
}
