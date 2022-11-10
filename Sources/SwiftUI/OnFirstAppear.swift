//
//  OnFirstAppear.swift
//  DJSwiftHelpers
//
//  Created by Darren Jones on 05/11/2022.
//  Copyright © 2022 Dappological Ltd. All rights reserved.
//

#if canImport(SwiftUI)
import SwiftUI

@available(iOS 13.0, macOS 10.15, watchOS 6.0, *)
public
extension View {
    
    /**
     A SwiftUI view modifier that executes a block of code only once during the first display of the view
     - Parameters:
        - action: A block of code to execute during the views first `onAppear`
     
     Note that this will stop the re-execution of code after navigating away and back to the view, however it should re-run if the view is re-drawn.
     */
    func onFirstAppear(_ action: @escaping () -> ()) -> some View {
        modifier(FirstAppear(action: action))
    }
}

@available(iOS 13.0, macOS 10.15, watchOS 6.0, *)
private
struct FirstAppear: ViewModifier {
    let action: () -> ()
    
    // Use this to only fire your block one time
    @State private var hasAppeared = false
    
    func body(content: Content) -> some View {
        // And then, track it here
        content.onAppear {
            guard !hasAppeared else { return }
            hasAppeared = true
            action()
        }
    }
}
#endif
