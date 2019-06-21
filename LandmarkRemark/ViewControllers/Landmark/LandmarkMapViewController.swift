//
//  LandmarkMapViewController.swift
//  LandmarkRemark
//
//  Created by Sai Tat Lam on 21/6/19.
//  Copyright © 2019 Sai Tat Lam. All rights reserved.
//

import UIKit
import MapKit

class LandmarkMapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    private var hasInitialisedMap = false

}


extension LandmarkMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        if hasInitialisedMap == false {
            mapView.showAnnotations([userLocation], animated: true)
            hasInitialisedMap = true
        }
    }
}
