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
        
        // It all begins with a clone.
        XCTAssertEqual(vm.filteredNoteCellViewModels.count, 10)
        XCTAssertFalse(vm.isSearching)
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
    
    func testCellViewModelAtIndexPathOutOfBound() {
        let cvm = vm.cellViewModel(at: IndexPath(row: 99, section: 0))
        XCTAssertNil(cvm)
    }
    
    func testNumberOfSection() {
        XCTAssertEqual(vm.numberOfSections, 1)
    }
    
    func testNumberOfRows() {
        XCTAssertEqual(vm.numberOfRows(inSection: 0), notes.count)
    }
    
    
    // MARK: - Search tests
    func testfilterContentForSearchText() {
        vm.filterContentForSearchText("3")
        XCTAssertEqual(vm.filteredNoteCellViewModels.count, 1)
        XCTAssertEqual(vm.filteredNoteCellViewModels.first!.messageLabelDisplayString, "Message 3")
    }
    
    func testNumberOfSectionDuringSearch() {
        vm.isSearching = true
        
        vm.filterContentForSearchText("3")
        XCTAssertEqual(vm.filteredNoteCellViewModels.count, 1)
        XCTAssertEqual(vm.numberOfSections, 1)
    }
    
    func testNumberOfRowsDuringSearch() {
        vm.isSearching = true
        
        XCTAssertEqual(vm.numberOfRows(inSection: 0), notes.count)
        vm.filterContentForSearchText("3")
        XCTAssertEqual(vm.numberOfRows(inSection: 0), 1)
    }
    
    func testCellViewModelAtIndexPathDuringSearch() {
        vm.isSearching = true
        
        vm.filterContentForSearchText("")
        for (idx, note) in notes.enumerated() {
            let cvm = vm.cellViewModel(at: IndexPath(row: idx, section: 0))
            XCTAssertNotNil(cvm)
            XCTAssertEqual(cvm!.note.toDictionary() as NSDictionary, note.toDictionary() as NSDictionary)
        }
        
        vm.filterContentForSearchText("3")
        XCTAssertEqual(vm.filteredNoteCellViewModels.count, 1)
        
        let cvm = vm.cellViewModel(at: IndexPath(row: 0, section: 0))
        XCTAssertNotNil(cvm)
        XCTAssertEqual(cvm!.messageLabelDisplayString, "Message 3")
    }
    
    func testCellViewModelAtIndexPathOutOfBoundDuringSearch() {
        vm.isSearching = true
        let cvm = vm.cellViewModel(at: IndexPath(row: 99, section: 0))
        XCTAssertNil(cvm)
    }
}
