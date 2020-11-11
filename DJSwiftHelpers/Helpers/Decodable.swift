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
