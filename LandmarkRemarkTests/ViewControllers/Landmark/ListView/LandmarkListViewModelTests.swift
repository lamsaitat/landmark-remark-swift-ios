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
    var notes: [Note]!
    var vm: LandmarkListViewModel!
    
    override func setUp() {
        var notes = [Note]()
        for idx in 0..<10 {
            let note = Note(latitude: wynyardCoord.latitude, longitude: wynyardCoord.longitude, message: "Message \(idx)", authorUid: "authorUid#\(idx)", authorDisplayName: "Author #\(idx)")
            notes.append(note)
        }
        self.notes = notes
        vm = LandmarkListViewModel(with: notes)
    }

    override func tearDown() {
        vm = nil
        notes = nil
    }

    func testInstantiation() {
        XCTAssertNotNil(vm.noteCellViewModels)
        XCTAssertEqual(vm.noteCellViewModels.count, 10)
    }
    
    func testCellViewModelAtIndexPath() {
        guard let vm = vm else {
            return XCTFail("LandmarkListViewModel instance not available to run the test.")
        }
        for (idx, note) in notes.enumerated() {
            let cvm = vm.cellViewModel(at: IndexPath(row: idx, section: 0))
            XCTAssertNotNil(cvm)
            XCTAssertEqual(cvm!.note.toDictionary() as NSDictionary, note.toDictionary() as NSDictionary)
        }
    }
    
    func testNumberOfSection() {
        XCTAssertEqual(vm.numberOfSections, 1)
    }
    
    func testNumberOfRows() {
        XCTAssertEqual(vm.numberOfRows(inSection: 0), notes.count)
    }
}
