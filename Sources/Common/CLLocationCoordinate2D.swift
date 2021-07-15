//
//  CLLocationCoordinate2D.swift
//  DJSwiftHelpers
//
//  Created by Darren Jones on 24/12/2020.
//  Copyright © 2020 Dappological Ltd. All rights reserved.
//

import Foundation
import CoreLocation

public
extension CLLocationCoordinate2D {
    
    /**
     Check if a `CLLocationCoordinate2D` is within a bounding box of coordinates
     */
    func locationIsInside(minLat:Double, maxLat:Double, minLong:Double, maxLong:Double) -> Bool {
        
        return self.latitude >= minLat && self.latitude <= maxLat && self.longitude >= minLong && self.longitude <= maxLong
    }
}
