//
//  PlatformWindow.swift
//  DJSwiftHelpers
//
//  Created by Darren Jones on 20/10/2025.
//

import SwiftUI

/// A scene that uses WindowGroup on iOS and Window on macOS.
@available(iOS 14.0, macOS 13.0, tvOS 14.0, watchOS 7.0, *)
public struct PlatformWindow<Content: View>: Scene {
    let title: String
    let id: String
    let content: () -> Content

    public init(_ title: String, id: String = UUID().uuidString, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.id = id
        self.content = content
    }

    public var body: some Scene {
        #if os(iOS)
        WindowGroup(title) {
            content()
        }
        #elseif os(macOS)
        Window(title, id: id) {
            content()
        }
        #endif
    }
}
