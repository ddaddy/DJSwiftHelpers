//
//  ToolbarContent.swift
//  DJSwiftHelpers
//
//  Created by Darren Jones on 10/09/2026.
//

#if os(iOS) || os(macOS)
import SwiftUI

@available(iOS 16.0, macOS 13.0, *)
public extension ToolbarContent {
    
    @inlinable
    @ToolbarContentBuilder func sharedBackgroundVisibilityBackport(_ visibility: Visibility) -> some ToolbarContent {
        if #available(iOS 26.0, macOS 26.0, *) {
            self.sharedBackgroundVisibility(visibility)
        } else {
            self
        }
    }
}
#endif
