//
//  SwiftUIView.swift
//  DJSwiftHelpers
//
//  Created by Darren Jones on 03/11/2024.
//

#if canImport(SwiftUI)
#if canImport(UIKit)
#if !os(watchOS)
import SwiftUI

/// A `UIActivityViewController` used to present a Share Sheet
///
/// Use in a `sheet` modifier
/// ```
/// struct ShareItem: Identifiable {
///     let id = UUID()
///     let data: Data
/// }
///
/// SomeView()
/// .sheet(item: $shareItem) { shareItem in
///     ActivityView(item: shareItem.data)
///         .presentationDetents([.medium])
/// }
/// ```
@available(iOS 13.0, *)
public struct ActivityView: UIViewControllerRepresentable {
    
    public init(item: Any,
                excludedActivityTypes: [UIActivity.ActivityType]? = nil,
                completionWithItemsHandler: UIActivityViewController.CompletionWithItemsHandler? = nil) {
        self.item = item
        self.excludedActivityTypes = excludedActivityTypes
        self.completionWithItemsHandler = completionWithItemsHandler
    }
    
    let item: Any
    let excludedActivityTypes: [UIActivity.ActivityType]?
    let completionWithItemsHandler: UIActivityViewController.CompletionWithItemsHandler?

    public func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityView>) -> UIActivityViewController {
        let activity = UIActivityViewController(activityItems: [item], applicationActivities: nil)
        if let excludedActivityTypes {
            activity.excludedActivityTypes = excludedActivityTypes
        }
        if let completionWithItemsHandler {
            activity.completionWithItemsHandler = completionWithItemsHandler
        }
        return activity
    }

    public func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ActivityView>) {}
}
#endif
#endif
#endif
