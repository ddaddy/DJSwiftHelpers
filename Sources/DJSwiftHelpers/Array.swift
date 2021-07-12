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
    
    /**
     Filters an array to return one of each item where the keyPath elements are unique
     - Parameters:
        - keyPath: The keypath to filter
     
     Example:
     ```
     struct Person {
         let firstName:String
         let surname:String
     }

     let array = [
         Person(firstName: "Darren", surname: "Jones"),
         Person(firstName: "Jenny", surname: "Jones"),
         Person(firstName: "Mark", surname: "Chadwick")
     ]
     
     let filtered = array.uniques(by: \.surname)
     
     // [{firstName "Darren", surname "Jones"}, {firstName "Mark", surname "Chadwick"}]
     ```
     */
    func uniques<T: Hashable>(by keyPath: KeyPath<Element, T>) -> [Element] {
        return reduce([]) { result, element in
            let alreadyExists = (result.contains(where: { $0[keyPath: keyPath] == element[keyPath: keyPath] }))
            return alreadyExists ? result : result + [element]
        }
    }
    
    /**
     Filters an array to return one of each item where the combined keyPath elements are unique
     - Parameters:
        - keyPath: The first keypath to filter
        - secondKeyPath: The second keypath to filter
     
     Example:
     ```
     struct Person {
         let firstName:String
         let surname:String
         let age:Int
     }

     let array = [
         Person(firstName: "Darren", surname: "Jones", age: 36),
         Person(firstName: "Darren", surname: "Jones", age: 42),
         Person(firstName: "Jenny", surname: "Jones", age: 42),
         Person(firstName: "Mark", surname: "Chadwick", age: 22)
     ]
     
     let filtered = array.uniques(by: \.firstName, and: \.surname)
     /*
     [
     {firstName: "Darren", surname: "Jones", age: 36},
     {firstName: "Jenny", surname: "Jones", age: 42},
     {firstName: "Mark", surname: "Chadwick", age: 22}
     ]
     */
     ```
     */
    func uniques<T: Hashable, U: Hashable>(by keyPath: KeyPath<Element, T>, and secondKeyPath: KeyPath<Element, U>) -> [Element] {
        return reduce([]) { result, element in
            let alreadyExists = (result.contains(where: { $0[keyPath: keyPath] == element[keyPath: keyPath] && $0[keyPath: secondKeyPath] == element[keyPath: secondKeyPath] }))
            return alreadyExists ? result : result + [element]
        }
    }
}
