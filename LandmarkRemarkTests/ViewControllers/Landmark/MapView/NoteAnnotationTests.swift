//
//  NoteAnnotationTests.swift
//  LandmarkRemarkTests
//
//  Created by Sai Tat Lam on 23/6/19.
//  Copyright © 2019 Sai Tat Lam. All rights reserved.
//

import XCTest
import MapKit
@testable import LandmarkRemark

class NoteAnnotationTests: BaseTestCase {
    
    var annotation: NoteAnnotation!
    
    override func setUp() {
        annotation = NoteAnnotation()
    }

    override func tearDown() {
        annotation = nil
    }

    func testInstantiation() {
        XCTAssertEqual(annotation.pinTintColor, MKPinAnnotationView.redPinColor())
    }

    func testChangingColor() {
        annotation.pinTintColor = MKPinAnnotationView.greenPinColor()
        XCTAssertEqual(annotation.pinTintColor, MKPinAnnotationView.greenPinColor())
    }
}
