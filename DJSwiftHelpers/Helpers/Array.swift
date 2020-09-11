//
//  Array.swift
//  Commute
//
//  Created by Darren Jones on 10/09/2020.
//  Copyright © 2020 Darren Jones. All rights reserved.
//

import Foundation

public
extension Array {
    
    /**
     Splits an `Array` into multiple arrays of size
     - Parameters:
        - size: How many items to put in each array
     */
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
