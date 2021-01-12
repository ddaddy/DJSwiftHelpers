//
//  Collection.swift
//  DJSwiftHelpers
//
//  Created by Darren Jones on 12/01/2021.
//  Copyright © 2021 Dappological Ltd. All rights reserved.
//

import Foundation

public
extension Collection {
    
    /**
     Removes the risk of `indexOutOfBounds` crashes.
     
     Example
     ```
     let array = [0,1,2,3]
     array[5] // Will crash with indexOutOfBounds
     array[safe: 5] // Returns nil
     ```
     */
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
