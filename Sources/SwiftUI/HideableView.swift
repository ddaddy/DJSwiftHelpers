//
//  HideableView.swift
//  VAT Making Tax Digital for iOS
//
//  Created by Darren Jones on 31/10/2024.
//  Copyright © 2024 Dappological Ltd. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, macOS 10.15, watchOS 6.0, *)
public extension View {
    func hideable(isHidden: Bool) -> some View {
        modifier(Hideable(isHidden: isHidden))
    }
}

@available(iOS 13.0, macOS 10.15, watchOS 6.0, *)
public struct Hideable: ViewModifier {
    let isHidden: Bool
    public func body(content: Content) -> some View {
        if !isHidden {
            content
        }
    }
}
