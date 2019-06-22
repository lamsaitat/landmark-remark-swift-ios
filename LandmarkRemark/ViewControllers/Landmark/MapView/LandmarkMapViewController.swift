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

    var viewModel: LandmarkMapViewModel = LandmarkMapViewModel(with: [Note]()) {
        didSet {
            reloadData()
        }
    }
}


extension LandmarkMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        if hasInitialisedMap == false {
            mapView.showAnnotations([userLocation], animated: true)
            hasInitialisedMap = true
        }
    }
    
    // MARK: Map Annotations.
    func reloadData() {
        // Remove existing annotations.
        mapView.removeAnnotations(mapView.annotations)
        
        let annotations = viewModel.annotationViewModels.map { vm -> MKAnnotation in
            return vm.annotation
        }
        mapView.addAnnotations(annotations)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? MKPointAnnotation else {
            return nil
        }
        
        let identifier = "NoteAnnotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if let annotationView = annotationView {
            annotationView.annotation = annotation
        } else {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        }
        
        return annotationView
    }
}
