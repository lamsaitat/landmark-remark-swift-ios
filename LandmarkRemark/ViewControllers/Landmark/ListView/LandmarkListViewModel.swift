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
    let noteCellViewModels: [NoteCellViewModel]
    let ref = Database.database().reference(withPath: Note.databaseName)
    
    required init(with notes: [Note]) {
        noteCellViewModels = notes.map({ note -> NoteCellViewModel in
            return NoteCellViewModel(with: note)
        })
    }
}
