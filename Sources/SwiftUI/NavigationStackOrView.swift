//
//  SwiftUIView.swift
//  DJSwiftHelpers
//
//  Created by Darren Jones on 03/11/2024.
//

#if canImport(SwiftUI)
import SwiftUI

/// Backward compatible `NavigationStack`
@available(iOS 13.0, *)
public struct NavigationStackPre16<Root>: View where Root: View {
    
    public init(@ViewBuilder root: @escaping () -> Root) {
        self.root = root
    }
    
    @ViewBuilder let root: () -> Root
    
    public var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack(root: root)
        } else {
            NavigationView(content: root)
                .navigationViewStyle(.stack)
        }
    }
}
#endif
