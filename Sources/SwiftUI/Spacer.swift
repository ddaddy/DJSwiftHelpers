//
//  Spacer.swift
//  DJSwiftHelpers
//
//  Created by Darren Jones on 28/10/2025.
//

import SwiftUI

/// `Spacer` only on macOS. `EmptyView` on others
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public struct SpacerMacOS: View {
    
    public init() {}
    
    public var body: some View {
#if os(macOS)
        Spacer()
#else
        EmptyView()
#endif
    }
}

/// `Spacer` only on macOS. `EmptyView` on others
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public struct SpacerIOS: View {
    
    public init() {}
    
    public var body: some View {
#if os(macOS)
        EmptyView()
#else
        Spacer()
#endif
    }
}
