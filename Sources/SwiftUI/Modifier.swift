//
//  Modifier.swift
//  DJSwiftHelpers
//
//  Created by Darren Jones on 20/10/2025.
//

#if canImport(SwiftUI)
import SwiftUI

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public extension View {
    
    /// A simple view modifier that allows you to use os specific modifiers
    ///
    /// ```swift
    /// Text("")
    ///     .modify {
    ///         if #available(iOS 26.0, *) {
    ///             $0.someModifer
    ///         } else {
    ///             $0
    ///         }
    ///     }
    /// ```
    public func modify<T: View>(@ViewBuilder _ modifier: (Self) -> T) -> some View {
        return modifier(self)
    }
}


#endif
