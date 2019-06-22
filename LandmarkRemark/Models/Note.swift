//
//  Note.swift
//  LandmarkRemark
//
//  Created by Sai Tat Lam on 22/6/19.
//  Copyright © 2019 Sai Tat Lam. All rights reserved.
//

import Foundation
import Firebase
import CoreLocation

struct Note {
    static let databaseName = "notes"
    
    let ref: DatabaseReference?
    let uid: String
    let coordinate: CLLocationCoordinate2D
    let message: String
    let authorUid: String
    let authorDisplayName: String
    
    init(uid: String = "", latitude: CLLocationDegrees, longitude: CLLocationDegrees, message: String, authorUid: String, authorDisplayName: String) {
        self.ref = nil
        self.uid = uid
        coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        self.message = message
        self.authorUid = authorUid
        self.authorDisplayName = authorDisplayName
    }
    
    init?(snapshot: DataSnapshot) {
        guard let value = snapshot.value as? [AnyHashable: Any],
            let coordinate = value["coordinate"] as? [AnyHashable: Any],
            let latitude = coordinate["latitude"] as? Double,
            let longitude = coordinate["longitude"] as? Double,
            let message = value["message"] as? String,
            let authorUid = value["authorUid"] as? String,
            let authorDisplayName = value["authorDisplayName"] as? String else {
                return nil
        }
        
        self.ref = snapshot.ref
        self.uid = snapshot.key
        self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        self.message = message
        self.authorUid = authorUid
        self.authorDisplayName = authorDisplayName
    }
    
    func toDictionary() -> [AnyHashable: Any] {
        return [
            "coordinate": [
                "latitude": coordinate.latitude,
                "longitude": coordinate.longitude
            ],
            "message": message,
            "authorUid": authorUid,
            "authorDisplayName": authorDisplayName
        ]
    }
}
