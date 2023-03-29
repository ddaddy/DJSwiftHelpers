//
//  Decodable.swift
//  Operators
//
//  Created by Darren Jones on 11/11/2020.
//  Copyright © 2020 Darren Jones. All rights reserved.
//

import Foundation

private struct Empty: Decodable { }

public
extension UnkeyedDecodingContainer {
    
    /**
     Skips to the next container
     
     Whilst iterating over a `nestedUnkeyedContainer` using
     ```
     while !container.isAtEnd {
        let object = try container.decode(Object.self)
     }
     ```
     any errors with an object will make the whole process `throw`.
     
     If we add our own `do,try,catch` to allow us to skip any errors, we end up in an infinate loop. To overcome this we can tell the decoder to decode into this `Empty` object will should always pass as it has no properties.
     
     Use it like this:
     ```
     while !container.isAtEnd {
        do {
            let object = try container.decode(Object.self)
            // Successfully decoded object here
        } catch {
            // Decoding Object failed, so tell the decoder to skip to the next
            let _ = try? container.skip()
        }
     }
     ```
     */
    mutating func skip() throws {
        _ = try decode(Empty.self)
    }
}

/**
 A custom `Decodable` object that can be used to decode arrays
 whose contents may sometimes fail but you want the whole array to be parsed.
 
 Use like this:
 ```
 let throwableArray = try attributes.decode([Throwable<T>].self, forKey: .key)
 ```
 Decodes as a `Result<T, Error>` type which you can get the succeeded results like this:
 ```
 let succesfullyDecoded = throwableArray.compactMap({ try? $0.result.get() })
 ```
 */
@available(*, deprecated, message: "Use LossyCodableList<Element> instead")
public
struct Throwable<T: Decodable>: Decodable {
    
    public let result: Result<T, Error>

    public init(from decoder: Decoder) throws {
        result = Result(catching: { try T(from: decoder) })
    }
}

/**
 Property wrapper that allows a `Decodable` `var` to be decoded from either a `String` or an `Int`.
 Useful when decoding `JSON` that might sometimes send a `String` instead of an `Int`.
 
 ```
 struct GeneralProduct: Decodable {
     var price: Double
     @Flexible var intId: Int // This can be decoded from either String or Int
     @Flexible var stringId: String // This can be decoded from either String or Int
 }
 ```
 [](https://stackoverflow.com/questions/47935705/using-codable-with-value-that-is-sometimes-an-int-and-other-times-a-string)
 */
@propertyWrapper
public
struct Flexible<T: FlexibleDecodable>: Decodable {
    public var wrappedValue: T
    
    public init(from decoder: Decoder) throws {
        wrappedValue = try T(container: decoder.singleValueContainer())
    }
}

public
protocol FlexibleDecodable {
    init(container: SingleValueDecodingContainer) throws
}

extension String: FlexibleDecodable {
    public init(container: SingleValueDecodingContainer) throws {
        if let string = try? container.decode(String.self) {
            self = string
        } else if let int = try? container.decode(Int.self) {
            self = String(int)
        } else {
            throw DecodingError.dataCorrupted(.init(codingPath: container.codingPath, debugDescription: "Invalid string value"))
        }
    }
}

extension Int: FlexibleDecodable {
    public init(container: SingleValueDecodingContainer) throws {
        if let int = try? container.decode(Int.self) {
            self = int
        } else if let string = try? container.decode(String.self), let int = Int(string) {
            self = int
        } else {
            throw DecodingError.dataCorrupted(.init(codingPath: container.codingPath, debugDescription: "Invalid int value"))
        }
    }
}
