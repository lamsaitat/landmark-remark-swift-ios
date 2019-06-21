//
//  ComposeNewNoteViewModel.swift
//  LandmarkRemark
//
//  Created by Sai Tat Lam on 21/6/19.
//  Copyright © 2019 Sai Tat Lam. All rights reserved.
//

import Foundation
import CoreLocation

class ComposeNewNoteViewModel {
    let coordinate: CLLocationCoordinate2D
    
    required init(with coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
