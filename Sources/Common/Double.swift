//
//  Double.swift
//  DJSwiftHelpers
//
//  Created by Darren Jones on 24/12/2020.
//  Copyright © 2020 Dappological Ltd. All rights reserved.
//

import Foundation

public
extension Double {
    
    /**
     Static function to compare 2 `Double` values with a specified precision for x decimal places.
     - Parameters:
        - lhs: A `Double`
        - rhs: A `Double`
        - precise: `Int` Number of decimal places
     ```
     Example:
     Double.equal(2.123, 2.146, precise: 1) // true
     ```
     */
    static func equal(_ lhs: Double, _ rhs: Double, precise value: Int? = nil) -> Bool {
        
        guard let value = value else {
            return lhs == rhs
        }
        
        return lhs.precised(value) == rhs.precised(value)
    }
    
    /**
     Round a `Double` to x decimal places
     ```
     Example:
     let t:Double = 2.123
     let y:Double = 4.365
     t.precised(1) // 2.1
     t.precised(2) // 2.12
     y.precised(1) // 4.4
     y.precised(2) // 4.37
     ```
     */
    func precised(_ value: Int = 1) -> Double {
        let offset = pow(10, Double(value))
        return (self * offset).rounded() / offset
    }
}
