//
//  LandmarkMapViewControllerTests.swift
//  LandmarkRemarkTests
//
//  Created by Sai Tat Lam on 21/6/19.
//  Copyright © 2019 Sai Tat Lam. All rights reserved.
//

import XCTest
import MapKit
@testable import LandmarkRemark

class LandmarkMapViewControllerTests: BaseTestCase {
    var vc: LandmarkMapViewController!
    
    override func setUp() {
        vc = createLandmarkMapViewController()
        vc.loadViewIfNeeded()
    }

    override func tearDown() {
        vc = nil
    }

    func testLoadView() {
        XCTAssertNotNil(vc.mapView)
    }
    
    func testReloadData() {
        guard let vc = vc, let mapView = vc.mapView else {
            return XCTFail("MapView not available to run the test.")
        }
        XCTAssertTrue(mapView.annotations.isEmpty)
        
        var notes = [Note]()
        for idx in 0..<10 {
            let note = Note(latitude: wynyardCoord.latitude, longitude: wynyardCoord.longitude, message: "Message \(idx)", authorUid: "authorUid#\(idx)", authorDisplayName: "Author #\(idx)")
            notes.append(note)
        }
        
        vc.viewModel = LandmarkMapViewModel(with: notes)
        vc.reloadData()
        XCTAssertEqual(mapView.annotations.count, 10)
        // Clean up
        mapView.removeAnnotations(mapView.annotations)
    }
    
    /**
     Tests that the setter will trigger reloadData()
    */
    func testViewModelSetter() {
        guard let vc = vc, let mapView = vc.mapView else {
            return XCTFail("MapView not available to run the test.")
        }
        XCTAssertTrue(mapView.annotations.isEmpty)
        
        var notes = [Note]()
        for idx in 0..<10 {
            let note = Note(latitude: wynyardCoord.latitude, longitude: wynyardCoord.longitude, message: "Message \(idx)", authorUid: "authorUid#\(idx)", authorDisplayName: "Author #\(idx)")
            notes.append(note)
        }
        
        vc.viewModel = LandmarkMapViewModel(with: notes)
        XCTAssertEqual(mapView.annotations.count, 10)
        // Clean up
        mapView.removeAnnotations(mapView.annotations)
    }
    
    func testAnnotationView() {
        for vm in vc.viewModel.annotationViewModels {
            let view = vc.mapView(vc.mapView, viewFor: vm.annotation)
            XCTAssertTrue(view is MKPinAnnotationView)
        }
    }
}
