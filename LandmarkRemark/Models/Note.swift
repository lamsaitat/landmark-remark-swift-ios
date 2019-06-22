//
//  Note.swift
//  LandmarkRemark
//
//  Created by Sai Tat Lam on 22/6/19.
//  Copyright © 2019 Sai Tat Lam. All rights reserved.
//

import Foundation
import CoreLocation

struct Note {
    let uid: String
    let coordinate: CLLocationCoordinate2D
    let message: String
    let authorUid: String
    let authorDisplayName: String
    
    init(uid: String, latitude: CLLocationDegrees, longitude: CLLocationDegrees, message: String, authorUid: String, authorDisplayName: String) {
        self.uid = uid
        coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        self.message = message
        self.authorUid = authorUid
        self.authorDisplayName = authorDisplayName
    }
}
