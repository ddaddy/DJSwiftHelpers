//
//  File.swift
//  DJSwiftHelpers
//
//  Created by Darren Jones on 17/02/2025.
//

#if canImport(SwiftUI)
#if canImport(AppKit)
#if os(macOS)
import AppKit
import SwiftUI

@available(macOS 10.15, *)
public struct SharingServicePicker: NSViewRepresentable {
    
    public init(isPresented: Binding<Bool>, sharingItems: [Any] = []) {
        self._isPresented = isPresented
        self.sharingItems = sharingItems
    }
    
    @Binding var isPresented: Bool
    var sharingItems: [Any] = []

    public func makeNSView(context: Context) -> NSView {
        let view = NSView()
        return view
    }

    public func updateNSView(_ nsView: NSView, context: Context) {
        if isPresented {
            let picker = NSSharingServicePicker(items: sharingItems)
            picker.delegate = context.coordinator

            // !! MUST BE CALLED IN ASYNC, otherwise blocks update
            DispatchQueue.main.async {
                picker.show(relativeTo: .zero, of: nsView, preferredEdge: .minY)
            }
        }
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator(owner: self)
    }

    public class Coordinator: NSObject, NSSharingServicePickerDelegate {
        let owner: SharingServicePicker

        init(owner: SharingServicePicker) {
            self.owner = owner
        }

        public func sharingServicePicker(_ sharingServicePicker: NSSharingServicePicker, didChoose service: NSSharingService?) {

            // do here whatever more needed here with selected service

            sharingServicePicker.delegate = nil   // << cleanup
            self.owner.isPresented = false        // << dismiss
        }
    }
}
#endif
#endif
#endif
