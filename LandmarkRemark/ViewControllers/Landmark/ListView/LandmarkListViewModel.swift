//
//  LandmarkListViewModel.swift
//  LandmarkRemark
//
//  Created by Sai Tat Lam on 22/6/19.
//  Copyright © 2019 Sai Tat Lam. All rights reserved.
//

import Foundation
import Firebase

class LandmarkListViewModel {
    var notes = [Note]()
    let ref = Database.database().reference(withPath: Note.databaseName)
    
    var notesDidRefreshBlock: (([Note]) -> Void)?
    
    init() {
        ref.observe(.value) { [weak self] snapshot in
            self?.notes = snapshot.children.allObjects.compactMap({ child -> Note? in
                guard let child = child as? DataSnapshot else {
                    return nil
                }
                return Note(snapshot: child)
            })
            self?.notesDidRefreshBlock?(self?.notes ?? [Note]())
        }
    }
}
