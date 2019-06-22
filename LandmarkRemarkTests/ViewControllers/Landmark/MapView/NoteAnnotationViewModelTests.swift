//
//  NoteAnnotationViewModelTests.swift
//  LandmarkRemarkTests
//
//  Created by Sai Tat Lam on 22/6/19.
//  Copyright © 2019 Sai Tat Lam. All rights reserved.
//

import XCTest
import CoreLocation
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
    
    func testAnnotation() {
        let annotation = vm.annotation
        
        XCTAssertEqual(annotation.title, "This is a test message")
        XCTAssertEqual(annotation.subtitle, "By: TestUser-001")
        XCTAssertEqual(annotation.coordinate.latitude, CLLocationDegrees(-33.8670864))
        XCTAssertEqual(annotation.coordinate.longitude, CLLocationDegrees(151.2077854))
    }
}
