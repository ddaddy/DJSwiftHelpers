//
//  PlatformVStack.swift
//  DJSwiftHelpers
//
//  Created by Darren Jones on 28/10/2025.
//

import SwiftUI

/// Uses a standard `VStack` on macOS, and a `ScrollView` with a `VStack` on iOS.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public struct PlatformVStack<Content: View>: View {
    
    var alignment: HorizontalAlignment
    var spacing: CGFloat?
    var iOSShowsIndicators: Bool
    var fillViewportOnIOS: Bool
    let content: Content   // store the view, not the closure
    
    public init(alignment: HorizontalAlignment = .center,
         spacing: CGFloat? = nil,
         iOSShowsIndicators: Bool = true,
         fillViewportOnIOS: Bool = false,
         @ViewBuilder content: () -> Content) {
        self.alignment = alignment
        self.spacing = spacing
        self.iOSShowsIndicators = iOSShowsIndicators
        self.fillViewportOnIOS = fillViewportOnIOS
        self.content = content()
    }
    
    public var body: some View {
#if os(iOS) || os(tvOS) || os(visionOS)
        Group {
            if fillViewportOnIOS {
                GeometryReader { proxy in
                    ScrollView(showsIndicators: iOSShowsIndicators) {
                        VStack(alignment: alignment, spacing: spacing) {
                            content
                            Spacer()
                        }
                        .frame(minHeight: proxy.size.height, alignment: .top)
                        .frame(maxWidth: .infinity)
                    }
                }
            } else {
                ScrollView(showsIndicators: iOSShowsIndicators) {
                    VStack(alignment: alignment, spacing: spacing) {
                        content
                    }
                }
            }
        }
#elseif os(macOS)
        VStack(alignment: alignment, spacing: spacing) { content }
#else
        VStack(alignment: alignment, spacing: spacing) { content }
#endif
    }
}
