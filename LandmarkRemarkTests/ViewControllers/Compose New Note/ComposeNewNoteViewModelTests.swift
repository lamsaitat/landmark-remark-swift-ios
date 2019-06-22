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
@testable import Firebase

class ComposeNewNoteViewModelTests: BaseTestCase {

    var vm: ComposeNewNoteViewModel!
    
    override func setUp() {
        vm = ComposeNewNoteViewModel(with: wynyardCoord)
    }
    
    override func tearDown() {
        vm = nil
    }
    
    func testInstantiation() {
        vm = ComposeNewNoteViewModel(with: wynyardCoord)
        XCTAssertNotNil(vm)
        XCTAssertNotNil(vm.coordinate)
    }
    
    /**
     Test the flow to publish a new note for a user, and validate the note being
     published by querying the database record.
     FIXME: There maybe a simpler way to verify the result directly from the
     database reference than performing a query against it, should review this
     whenever I learn of such way.
     */
    func testPublishNewNote() {
        guard let vm = vm else {
            return XCTFail("ComposeNewNoteViewModel instance not available to run the test.")
        }
        let email = "testuser1@example.com"
        let password = "Th1s1sAWeakPassw0rd"
        
        // Step 1: Authenticate user for composing a note.
        let loginExpectation = XCTestExpectation(description: "Waiting for login to complete.")
        Auth.auth().signIn(withEmail: email, password: password) { (_, error) in
            if let error = error {
                return XCTFail("Unexpected error while logging in user: \(error.localizedDescription)")
            }
            loginExpectation.fulfill()
        }
        wait(for: [loginExpectation], timeout: 30.0)
        XCTAssertNotNil(Auth.auth().currentUser)
        
        // Step 2: Compose a note for the authenticated user.
        let publishExpectation = XCTestExpectation(description: "Waiting for publish to complete.")
        let message = "This is a test message"
        var dbRef: DatabaseReference!
        vm.publishNewNote(message) { (ref, error) in
            if let error = error {
                return XCTFail("Unexpected error while puhblishing note: \(error.localizedDescription)")
            }
            dbRef = ref
            // Test for note returned with Uid.
            publishExpectation.fulfill()
        }
        wait(for: [publishExpectation], timeout: 10.0)
        guard dbRef != nil, let key = dbRef.key else {
            return XCTFail("New note's database reference not found.")
        }
        
        // Step 3: Verify the new entry actually exists in the db.
        let queryExpectation = XCTestExpectation(description: "Waiting for db query to complete.")
        var resultingSnapshot: DataSnapshot!
        let noteRef = Database.database().reference(withPath: Note.databaseName).child(key)
        noteRef.observeSingleEvent(of: .value) { snapshot in
            resultingSnapshot = snapshot
            queryExpectation.fulfill()
        }
        wait(for: [queryExpectation], timeout: 10.0)
        // Query the db to validate the data.
        XCTAssertNotNil(resultingSnapshot)
        guard let dict = resultingSnapshot.value as? [String: AnyObject] else {
            return XCTFail("Failed to retrieve dictionary from fetched snapshot.")
        }
        XCTAssertEqual(dict["message"] as? String, message)
        XCTAssertEqual(dict["authorUid"] as? String, Auth.auth().currentUser!.uid)
        
        // Clean up.
        noteRef.removeValue()
        try? Auth.auth().signOut()
    }
    
    func testPublishingNewNoteWithoutUserSession() {
        // Make sure there is no signed in user.
        try? Auth.auth().signOut()
        
        let publishExpectation = XCTestExpectation(description: "Waiting for publish to complete.")
        let message = "This is a test message"
        var resultingError: Error!
        vm.publishNewNote(message) { (ref, error) in
            if ref != nil {
                return XCTFail("Unexpected database reference found.")
            }
            resultingError = error
            // Test for note returned with Uid.
            publishExpectation.fulfill()
        }
        wait(for: [publishExpectation], timeout: 10.0)
        XCTAssertNotNil(resultingError)
        XCTAssertEqual(resultingError.localizedDescription, "Unable to obtain current session. Please login.")
    }
}
