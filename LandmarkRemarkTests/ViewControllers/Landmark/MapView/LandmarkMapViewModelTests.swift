//
//  LandmarkMapViewModelTests.swift
//  LandmarkRemarkTests
//
//  Created by Sai Tat Lam on 22/6/19.
//  Copyright © 2019 Sai Tat Lam. All rights reserved.
//

import XCTest
@testable import LandmarkRemark

class LandmarkMapViewModelTests: BaseTestCase {
    var notes: [Note]!
    var vm: LandmarkMapViewModel!
    
    override func setUp() {
        var notes = [Note]()
        for idx in 0..<10 {
            let note = Note(latitude: wynyardCoord.latitude, longitude: wynyardCoord.longitude, message: "Message \(idx)", authorUid: "authorUid#\(idx)", authorDisplayName: "Author #\(idx)")
            notes.append(note)
        }
        self.notes = notes
        
        vm = LandmarkMapViewModel(with: notes)
    }

    override func tearDown() {
        vm = nil
        notes = nil
    }

    func testInstantiation() {
        XCTAssertNotNil(vm.annotationViewModels)
        XCTAssertEqual(vm.annotationViewModels.count, 10)
    }
}
