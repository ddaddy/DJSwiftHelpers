//
//  Array.swift
//  Commute
//
//  Created by Darren Jones on 10/09/2020.
//  Copyright © 2020 Darren Jones. All rights reserved.
//

import Foundation

public
extension Array where Element: Equatable {
    
    /**
     Remove an element from an array
     - Parameters:
        - element: The element to remove
     
     If the array has more than 1 of the same element, then only the first will be removed
     */
    mutating func remove(element: Element) {
        if let i = self.firstIndex(of: element) {
            self.remove(at: i)
        }
    }
    
    /**
     Moves an element to a new index within the Array
     - Parameters:
        - element: The element to move
        - newIndex: The index to place the elemnt within this Array
     */
    mutating func move(_ element: Element, to newIndex: Index) {
        if let oldIndex: Int = self.firstIndex(of: element) { self.move(from: oldIndex, to: newIndex) }
    }
}

public
extension Array
{
    
    /**
     Moves the element at a specific index to a new index
     - Parameters:
        - oldIndex: The index of the element to move
        - newIndex: The index to place the element
     */
    mutating func move(from oldIndex: Index, to newIndex: Index) {
        // Don't work for free and use swap when indices are next to each other - this
        // won't rebuild array and will be super efficient.
        if oldIndex == newIndex { return }
        if abs(newIndex - oldIndex) == 1 { return self.swapAt(oldIndex, newIndex) }
        self.insert(self.remove(at: oldIndex), at: newIndex)
    }
}

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

#if canImport(Combine)
import Combine

@available(iOS 13.0, watchOS 6.0, macOS 10.15, *)
public
extension Array where Element: ObservableObject {
    
    /// Adds a listener to array elements
    /// - Parameters:
    ///     - cancellables: An `Array` of `AnyCancellable`'s to hold the strong reference to listeners
    ///     - change: A closure that is triggered whenever an element in the array has been updated by firing `objectWillChange`
    ///
    /// As arrays containing class objects do not trigger any kind of update if an element
    /// updates one of it's variables, we need to attach a listener to every element of the array.
    /// The listener needs a strong reference, so you must pass in an array to hold them.
    ///
    /// Example:
    /// ```swift
    /// var cancellables = [AnyCancellable]()
    /// array.elementChangeListener(cancellables: &cancellables) { element in
    ///     // Do something when an array element changes
    /// }
    /// ```
    func elementChangeListener(cancellables: inout [AnyCancellable], change: @escaping (Element)->()) {
        
        cancellables.removeAll()
        forEach { element in
            let c = element.objectWillChange.sink { _ in
                change(element)
            }
            cancellables.append(c)
        }
    }
}
#endif
