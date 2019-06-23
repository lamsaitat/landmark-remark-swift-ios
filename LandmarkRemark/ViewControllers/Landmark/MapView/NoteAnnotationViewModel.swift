//
//  NoteAnnotationViewModel.swift
//  LandmarkRemark
//
//  Created by Sai Tat Lam on 22/6/19.
//  Copyright © 2019 Sai Tat Lam. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit
import Firebase

class NoteAnnotationViewModel {
    let note: Note
    
    required init(with note: Note) {
        self.note = note
    }
    
    lazy var annotation: MKAnnotation = {
        let annotation = NoteAnnotation()
        annotation.title = annotationTitleDisplayString
        annotation.subtitle = annotationSubtitleDisplayString
        annotation.coordinate = annotationCoordinate
        annotation.pinTintColor = annotationPinTintColor
        return annotation
    }()
}


// MARK: - Display logic
extension NoteAnnotationViewModel {
    var annotationTitleDisplayString: String {
        return note.message
    }
    
    var annotationSubtitleDisplayString: String {
        return "By: " + note.authorDisplayName
    }
    
    var annotationCoordinate: CLLocationCoordinate2D {
        return note.coordinate
    }
    
    var annotationPinTintColor: UIColor {
        if let currentUser = Auth.auth().currentUser, note.authorUid == currentUser.uid {
            return MKPinAnnotationView.greenPinColor()
        }
        return MKPinAnnotationView.redPinColor()
    }
}
