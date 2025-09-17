//
//  LiquidGlass.swift
//  DJSwiftHelpers
//
//  Created by Darren Jones on 17/09/2025.
//

#if canImport(SwiftUI)
import SwiftUI

@available(iOS 13.0, macOS 10.15, watchOS 6.0, *)
public
extension View {
    public func glassButtonStyle<Fallback: PrimitiveButtonStyle>(prominent: Bool, fallback: Fallback) -> some View {
        modifier(GlassButtonStyle(prominent: prominent, fallback: fallback))
    }
}

@available(iOS 13.0, macOS 10.15, watchOS 6.0, *)
fileprivate
struct GlassButtonStyle<Fallback: PrimitiveButtonStyle>: ViewModifier {
    
    let prominent: Bool
    let fallback: Fallback
    
    func body(content: Content) -> some View {
        if #available(iOS 26.0, macOS 26.0, watchOS 26.0, *) {
            if prominent {
                content.buttonStyle(.glassProminent)
            } else {
                content.buttonStyle(.glass)
            }
        } else {
            content.buttonStyle(fallback)
        }
    }
}

#endif // canImport(SwiftUI)
