//
//  NoteTests.swift
//  LandmarkRemarkTests
//
//  Created by Sai Tat Lam on 22/6/19.
//  Copyright © 2019 Sai Tat Lam. All rights reserved.
//

import XCTest
@testable import LandmarkRemark

class NoteTests: BaseTestCase {

    func testNoteInstantiation() {
        let uid = "c4b1c96a-e229-4800-acfe-2125932c61bd"
        let latitude = Double(-33.8670864)
        let longitude = Double(151.2077854)
        let message = "This is a short message"
        let userId = "590fc88a-80ac-40b2-be05-77d4479cb3f4"
        let username = "Testuser001"
        
        
        let note = Note(uid: uid, latitude: latitude, longitude: longitude, message: message, authorUid: userId, authorDisplayName: username)
        XCTAssertNotNil(note)
        XCTAssertEqual(note.uid, uid)
        XCTAssertEqual(note.coordinate.latitude, latitude)
        XCTAssertEqual(note.coordinate.longitude, longitude)
        XCTAssertEqual(note.message, message)
        XCTAssertEqual(note.authorUid, userId)
        XCTAssertEqual(note.authorDisplayName, username)
    }
    
    /**
     Test that the toDictionary() function will write essential properties to dictionary correctly.
     */
    func testArchivingToDictionary() {
        let latitude = Double(-33.8670864)
        let longitude = Double(151.2077854)
        let message = "This is a short message"
        let userId = "590fc88a-80ac-40b2-be05-77d4479cb3f4"
        let username = "Testuser001"
        
        let expected: [AnyHashable: Any] = [
            "coordinate": [
                "latitude": latitude,
                "longitude": longitude
            ],
            "message": message,
            "authorUid": userId,
            "authorDisplayName": username
            ]
        
        let note = Note(latitude: latitude, longitude: longitude, message: message, authorUid: userId, authorDisplayName: username)
        let dict = note.toDictionary()
        XCTAssertNotNil(dict)
        XCTAssertEqual(dict as NSDictionary, expected as NSDictionary)
    }
}
