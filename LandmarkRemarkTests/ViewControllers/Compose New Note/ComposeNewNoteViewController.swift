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
}
