//
//  WindowAccessor.swift
//  DJSwiftHelpers
//
//  Created by Darren Jones on 25/06/2025.
//

#if canImport(SwiftUI)
#if canImport(AppKit)
#if os(macOS)
import SwiftUI

/// ViewModifier that captures the NSWindow hosting this view and writes it to a binding.
@available(macOS 10.15, *)
private struct CaptureWindowModifier: ViewModifier {
    @Binding var window: NSWindow?
    func body(content: Content) -> some View {
        // Use the existing WindowAccessor to report the window once the hierarchy is attached.
        content.background(WindowAccessor { window = $0 })
    }
    
    /// Reads the `NSWindow` that contains a SwiftUI hierarchy.
    private struct WindowAccessor: NSViewRepresentable {
        var callback: (NSWindow?) -> Void
        func makeNSView(context: Context) -> NSView {
            let view = NSView()
            DispatchQueue.main.async { callback(view.window) }
            return view
        }
        func updateNSView(_ nsView: NSView, context: Context) {}
    }
}

@available(macOS 10.15, *)
public extension View {
    /// Captures the NSWindow that hosts this view and stores it in the given binding.
    ///
    /// Useful when closing a specific window.
    /// ```
    /// @State private var hostingWindow: NSWindow?
    /// SomeView()
    ///     .captureWindow(into: $hostingWindow)
    ///
    /// func close() {
    ///     hostingWindow?.performClose(nil)
    /// }
    /// ```
    func captureWindow(into window: Binding<NSWindow?>) -> some View {
        modifier(CaptureWindowModifier(window: window))
    }
}

#endif
#endif
#endif
