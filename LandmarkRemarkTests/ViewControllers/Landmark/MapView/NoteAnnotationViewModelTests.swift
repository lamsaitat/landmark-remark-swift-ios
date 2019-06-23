//
//  NoteAnnotationViewModelTests.swift
//  LandmarkRemarkTests
//
//  Created by Sai Tat Lam on 22/6/19.
//  Copyright © 2019 Sai Tat Lam. All rights reserved.
//

import XCTest
import CoreLocation
import Firebase
import MapKit
@testable import LandmarkRemark

class NoteAnnotationViewModelTests: BaseTestCase {
    
    var vm: NoteAnnotationViewModel!
    
    override func setUp() {
        vm = NoteAnnotationViewModel(with: sampleNote)
    }

    override func tearDown() {
        vm = nil
    }

    func testAnnotationTitleDisplayString() {
        XCTAssertEqual(vm.annotationTitleDisplayString, "This is a test message")
    }
    
    func testAnnotationSubtitleDisplayString() {
        XCTAssertEqual(vm.annotationSubtitleDisplayString, "By: TestUser-001")
    }
    
    func testAnnotationCoordinate() {
        XCTAssertEqual(vm.annotationCoordinate.latitude, CLLocationDegrees(-33.8670864))
        XCTAssertEqual(vm.annotationCoordinate.longitude, CLLocationDegrees(151.2077854))
    }
    
    func testAnnotationPinTintColor() {
        let logoutExpectation = XCTestExpectation(description: "Waiting for logout to complete")
        try? Auth.auth().signOut()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            logoutExpectation.fulfill()
        }
        wait(for: [logoutExpectation], timeout: 15.0)
        
        XCTAssertEqual(vm.annotationPinTintColor, MKPinAnnotationView.redPinColor())
        
        let loginExpectation = XCTestExpectation(description: "Wait for login.")
        let email = "testuser1@example.com"
        let password = "Th1s1sAWeakPassw0rd"
        Auth.auth().signIn(withEmail: email, password: password) { (_, error) in
            if let error = error {
                fatalError("Unexpected error logging in: \(error.localizedDescription)")
            }
            loginExpectation.fulfill()
        }
        wait(for: [loginExpectation], timeout: 15.0)
        
        XCTAssertNotNil(Auth.auth().currentUser)
        XCTAssertEqual(vm.annotationPinTintColor, MKPinAnnotationView.greenPinColor())
        
        // Clean up
        try? Auth.auth().signOut()
    }
    
    func testAnnotation() {
        let annotation = vm.annotation
        
        XCTAssertEqual(annotation.title, "This is a test message")
        XCTAssertEqual(annotation.subtitle, "By: TestUser-001")
        XCTAssertEqual(annotation.coordinate.latitude, CLLocationDegrees(-33.8670864))
        XCTAssertEqual(annotation.coordinate.longitude, CLLocationDegrees(151.2077854))
    }
}
