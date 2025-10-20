//
//  ButtonRole.swift
//  DJSwiftHelpers
//
//  Created by Darren Jones on 17/09/2025.
//

#if canImport(SwiftUI)
import SwiftUI

@available(iOS 15.0, macOS 12.0, watchOS 8.0, *)
public extension ButtonRole {
    
    static func confirm(fallback: ButtonRole?) -> ButtonRole? {
        if #available(iOS 26.0, macOS 26.0, watchOS 26.0, *) {
            return .confirm
        } else {
            return fallback
        }
    }
    
    static func close(fallback: ButtonRole?) -> ButtonRole? {
        if #available(iOS 26.0, macOS 26.0, watchOS 26.0, *) {
            return .close
        } else {
            return fallback
        }
    }
}

#endif // canImport(SwiftUI)
