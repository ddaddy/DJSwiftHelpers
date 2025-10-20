//
//  MailComposer.swift
//  DJSwiftHelpers
//
//  Created by Darren Jones on 20/10/2025.
//

#if os(iOS)
import SwiftUI
import UIKit
import MessageUI

/// A SwiftUI view to display the iOS Mail Sheet
///
/// - Parameter presentation: A `Binding` for a bool that makes the view appear when switched to `true`
/// - Parameter result: A `Binding` that receives the end result
///
/// Use it by adding it to the view like this:
/// ```swift
/// @State var result: Result<MFMailComposeResult, Error>? = nil
/// @State var isShowingMailComposer = false
/// .sheet(isPresented: $isShowingMailComposer) {
///     MailComposer(result: $result) { composer in
///         composer.setSubject(emailSubject)
///         composer.setToRecipients([emailRecipient])
///         composer.setMessageBody(defaultMessage, isHTML: false)
///     }
/// }
/// ```
@available(iOS 13, *)
public struct MailComposer: UIViewControllerRepresentable {
    
    @Environment(\.presentationMode) private var presentation
    @Binding public var result: Result<MFMailComposeResult, Error>?
    public var configure: ((MFMailComposeViewController) -> Void)?
    
    public class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        
        @Binding var presentation: PresentationMode
        @Binding var result: Result<MFMailComposeResult, Error>?
        
        init(presentation: Binding<PresentationMode>,
             result: Binding<Result<MFMailComposeResult, Error>?>) {
            _presentation = presentation
            _result = result
        }
        
        public func mailComposeController(_ controller: MFMailComposeViewController,
                                          didFinishWith result: MFMailComposeResult,
                                          error: Error?) {
            defer {
                $presentation.wrappedValue.dismiss()
            }
            guard error == nil else {
                self.result = .failure(error!)
                return
            }
            self.result = .success(result)
        }
    }
    
    public func makeCoordinator() -> Coordinator {
        return Coordinator(presentation: presentation,
                           result: $result)
    }
    
    public func makeUIViewController(context: UIViewControllerRepresentableContext<MailComposer>) -> MFMailComposeViewController {
        let vc = MFMailComposeViewController()
        vc.mailComposeDelegate = context.coordinator
        configure?(vc)
        return vc
    }
    
    public func updateUIViewController(
        _ uiViewController: MFMailComposeViewController,
        context: UIViewControllerRepresentableContext<MailComposer>) {
            
        }
}
#endif

