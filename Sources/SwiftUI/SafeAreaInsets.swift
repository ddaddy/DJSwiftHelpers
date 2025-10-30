//
//  SafeAreaInsets.swift
//  DJSwiftHelpers
//
//  Created by Darren Jones on 30/10/2025.
//

import SwiftUI

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
private struct SafeAreaInsetsKey: EnvironmentKey {
    static var defaultValue: EdgeInsets = .init()
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public extension EnvironmentValues {
    var safeAreaInsets: EdgeInsets {
        get { self[SafeAreaInsetsKey.self] }
        set { self[SafeAreaInsetsKey.self] = newValue }
    }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
private struct SafeAreaInsetsPreferenceKey: PreferenceKey {
    static var defaultValue: EdgeInsets = .init()
    static func reduce(value: inout EdgeInsets, nextValue: () -> EdgeInsets) {
        let n = nextValue()
        value = EdgeInsets(
            top: max(value.top, n.top),
            leading: max(value.leading, n.leading),
            bottom: max(value.bottom, n.bottom),
            trailing: max(value.trailing, n.trailing)
        )
    }
}

/// Modifier that reads `GeometryProxy.safeAreaInsets` and injects into the Environment
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
private struct InjectSafeAreaInsets: ViewModifier {
    @State private var insets: EdgeInsets = .init()

    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { proxy in
                    Color.clear
                        .preference(
                            key: SafeAreaInsetsPreferenceKey.self,
                            value: EdgeInsets(
                                top: proxy.safeAreaInsets.top,
                                leading: proxy.safeAreaInsets.leading,
                                bottom: proxy.safeAreaInsets.bottom,
                                trailing: proxy.safeAreaInsets.trailing
                            )
                        )
                }
            )
            .onPreferenceChange(SafeAreaInsetsPreferenceKey.self) {
                insets = $0
            }
            .environment(\.safeAreaInsets, insets)
    }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public extension View {
    /// Modifier that reads `GeometryProxy.safeAreaInsets` and injects into the Environment
    ///
    /// ```swift
    /// @Environment(\.safeAreaInsets) private var safeAreaInsets
    /// ```
    func injectSafeAreaInsets() -> some View { modifier(InjectSafeAreaInsets()) }
}
