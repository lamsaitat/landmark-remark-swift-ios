//
//  ComposeNewNoteViewModel.swift
//  LandmarkRemark
//
//  Created by Sai Tat Lam on 21/6/19.
//  Copyright © 2019 Sai Tat Lam. All rights reserved.
//

import Foundation
import Firebase
import CoreLocation

class ComposeNewNoteViewModel {
    let coordinate: CLLocationCoordinate2D
    
    required init(with coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
    
    func publishNewNote(_ message: String, completion: ((DatabaseReference?, Error?) -> Void)?) {
        guard let user = Auth.auth().currentUser else {
            let error = NSError(domain: Bundle.main.bundleIdentifier!, code: 403, userInfo: [
                NSLocalizedDescriptionKey: "Unable to obtain current session. Please login."])
            completion?(nil, error)
            return
        }
        
        let note = Note(latitude: coordinate.latitude, longitude: coordinate.longitude, message: message, authorUid: user.uid, authorDisplayName: user.displayName ?? "")
        
        Database.database().reference(withPath: Note.databaseName).childByAutoId().setValue(note.toDictionary() as Any) { (error, ref) in
            if let error = error {
                completion?(nil, error)
            } else {
                completion?(ref, nil)
            }
        }
    }
}
