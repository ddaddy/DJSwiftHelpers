//
//  Codable.swift
//  DJSwiftHelpers
//
//  Created by Darren Jones on 24/02/2021.
//  Copyright © 2021 Dappological Ltd. All rights reserved.
//

import Foundation

/**
 A new way to decode/encode arrays whilst skipping any elements that fail.
 
 Can be used like this:
 ```
 let throwableArray = try attributes.decode(LossyCodableList<T>.self, forKey: .key)
 let resultingArray = throwableArray.elements
 ```
 Or can be used directly with a property wrapper like this:
 ```
 @LossyCodableList var items: [Item]
 ```
 */
@propertyWrapper
public
struct LossyCodableList<Element> {
    
    public var elements: [Element]
    
    public var wrappedValue: [Element] {
        get { elements }
        set { elements = newValue }
    }
}

extension LossyCodableList: Decodable where Element: Decodable {
    
    private struct ElementWrapper: Decodable {
        var element: Element?

        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            element = try? container.decode(Element.self)
        }
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let wrappers = try container.decode([ElementWrapper].self)
        elements = wrappers.compactMap(\.element)
    }
}

extension LossyCodableList: Encodable where Element: Encodable {
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()

        for element in elements {
            try? container.encode(element)
        }
    }
}
