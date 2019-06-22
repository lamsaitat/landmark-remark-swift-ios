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
    var notes: [Note] {
        return [
            Note(latitude: wynyardCoord.latitude, longitude: wynyardCoord.longitude, message: "This is message 0", authorUid: "authorUid-1", authorDisplayName: "TestUser1"),
            Note(latitude: wynyardCoord.latitude, longitude: wynyardCoord.longitude, message: "This is message 1", authorUid: "authorUid-1", authorDisplayName: "TestUser1"),
            Note(latitude: wynyardCoord.latitude, longitude: wynyardCoord.longitude, message: "This is message 2", authorUid: "authorUid-1", authorDisplayName: "TestUser1")
        ]
    }
    override func setUp() {
        vc = createLandmarkListViewController()
        vc.viewModel = LandmarkListViewModel(with: notes)
        vc.loadViewIfNeeded()
    }

    override func tearDown() {
        vc = nil
    }
    
    func testLoadView() {
        XCTAssertNotNil(vc)
        XCTAssertNotNil(vc.tableView)
    }
    
    func testNumberOfSections() {
        XCTAssertEqual(vc.numberOfSections(in: vc.tableView), vc.viewModel.numberOfSections)
    }
    
    func testNumberOfRows() {
        for section in 0..<vc.numberOfSections(in: vc.tableView) {
            XCTAssertEqual(vc.tableView(vc.tableView, numberOfRowsInSection: section), vc.viewModel.numberOfRows(inSection: section))
        }
    }
    
    func testConfigureNoteCell() {
        let indexPath = IndexPath(row: 0, section: 0)
        guard let cell = vc.tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as? NoteCell else {
            return XCTFail("Unable to create NoteCell instance to run the test.")
        }
        
        for note in notes {
            let cvm = NoteCellViewModel(with: note)
            vc.configure(cell, withCellViewModel: cvm)
            XCTAssertEqual(cell.authorLabel.text, cvm.authorLabelDisplayString)
            XCTAssertEqual(cell.messageLabel.text, cvm.messageLabelDisplayString)
            XCTAssertEqual(cell.locationLabel.text, cvm.locationLabelDisplayString)
        }
    }
    
    func testCellForRowAtIndexPath() {
        for section in 0..<vc.numberOfSections(in: vc.tableView) {
            for row in 0..<vc.tableView(vc.tableView, numberOfRowsInSection: section) {
                let indexPath = IndexPath(row: row, section: section)
                guard let cell = vc.tableView(vc.tableView, cellForRowAt: indexPath) as? NoteCell else {
                    return XCTFail("Incorrect cell type returned.")
                }
                let note = notes[row]
                let cvm = NoteCellViewModel(with: note)
                XCTAssertEqual(cell.authorLabel.text, cvm.authorLabelDisplayString)
                XCTAssertEqual(cell.messageLabel.text, cvm.messageLabelDisplayString)
                XCTAssertEqual(cell.locationLabel.text, cvm.locationLabelDisplayString)
            }
        }
    }
}
