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
    func modify<T: View>(@ViewBuilder _ modifier: (Self) -> T) -> some View {
        return modifier(self)
    }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public extension View {
    /// Apply extra modifiers only on macOS.
    @ViewBuilder
    func macOS<Content: View>(_ transform: (Self) -> Content) -> some View {
#if os(macOS)
        transform(self)
#else
        self
#endif
    }
    
    /// Apply extra modifiers only on iOS.
    @ViewBuilder
    func iOS<Content: View>(_ transform: (Self) -> Content) -> some View {
#if os(iOS)
        transform(self)
#else
        self
#endif
    }
    
    /// Apply a platform-specific font. Pass `nil` to omit on a platform.
    @ViewBuilder
    func platformFont( macOS mac: Font? = nil, iOS ios: Font? = nil) -> some View {
#if os(macOS)
        if let mac { self.font(mac) } else { self }
#elseif os(iOS)
        if let ios { self.font(ios) } else { self }
#else
        self
#endif
    }
}
#endif
