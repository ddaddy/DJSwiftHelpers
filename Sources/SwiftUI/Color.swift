//
//  Color.swift
//  DJSwiftHelpers
//
//  Created by Darren Jones on 20/10/2025.
//

import SwiftUI

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Color {
#if os(iOS)
    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    public init(nsColor: UIColor) {
        self.init(uiColor: nsColor)
    }
#elseif os(macOS)
    @available(macOS 12.0, *)
    public init(uiColor: NSColor) {
        self.init(nsColor: uiColor)
    }
#endif
}
