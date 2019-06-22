//
//  LandmarkMapViewModel.swift
//  LandmarkRemark
//
//  Created by Sai Tat Lam on 22/6/19.
//  Copyright © 2019 Sai Tat Lam. All rights reserved.
//

import Foundation

class LandmarkMapViewModel {
    let annotationViewModels: [NoteAnnotationViewModel]
    
    required init(with notes: [Note]) {
        annotationViewModels = notes.map({ note -> NoteAnnotationViewModel in
            return NoteAnnotationViewModel(with: note)
        })
    }
}
