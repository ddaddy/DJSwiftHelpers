//
//  SwiftUIView.swift
//  DJSwiftHelpers
//
//  Created by Darren Jones on 03/11/2024.
//

#if canImport(SwiftUI)
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
    
    public init(item: Any) {
        self.item = item
    }
    
    let item: Any

    public func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityView>) -> UIActivityViewController {
        return UIActivityViewController(activityItems: [item], applicationActivities: nil)
    }

    public func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ActivityView>) {}
}
#endif
