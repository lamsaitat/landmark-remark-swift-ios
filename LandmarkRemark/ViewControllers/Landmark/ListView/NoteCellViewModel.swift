//
//  NoteCellViewModel.swift
//  LandmarkRemark
//
//  Created by Sai Tat Lam on 22/6/19.
//  Copyright © 2019 Sai Tat Lam. All rights reserved.
//

import Foundation

class NoteCellViewModel {
    let note: Note
    
    required init(with note: Note) {
        self.note = note
    }
}


// MARK: - View Model Display Logic
extension NoteCellViewModel {
    var messageLabelDisplayString: String? {
        return note.message
    }
    
    var locationLabelDisplayString: String? {
        return "Location: (\(note.coordinate.latitude), \(note.coordinate.longitude))"
    }
    
    var authorLabelDisplayString: String? {
        return "Submitted by: \(note.authorDisplayName)"
    }
}
