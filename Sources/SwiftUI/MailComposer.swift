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

@available(iOS 15.0, *)
extension View {
    
    /// A view modifier that can present a mail composer view
    ///
    /// - Parameter isShowing: A binding to show the email composer
    /// - Parameter composer: The `MailComposer` to use
    /// - Parameter onFail: A view builder containing the button to display in the failure sheet
    ///
    /// ```swift
    /// .mailComposerView(isShowing: $isShowingMailComposer, with: Feedback.mailComposer(), onFail: {
    ///     Button("Share Logs") {
    ///         shareLogs()
    ///     }
    /// })
    /// ```
    @MainActor
    public func mailComposerView<A>(isShowing: Binding<Bool>, with composer: MailComposer, @ViewBuilder onFail: (@escaping () -> A)) -> some View where A: View {
        modifier(MailComposerView(isShowing: isShowing, with: composer, onFail: onFail))
    }
}

@available(iOS 15.0, *)
@MainActor
private struct MailComposerView<A>: ViewModifier where A: View {
    
    internal init(isShowing: Binding<Bool>, with composer: MailComposer, @ViewBuilder onFail: @escaping () -> A) {
        self._isShowing = isShowing
        self.composer = composer
        self.onFail = onFail
    }
    
    @Binding private var isShowing: Bool
    private var composer: MailComposer
    private var onFail: () -> A
    
    @State private var showComposer = false
    @State private var showFailOptions = false
    
    func body(content: Content) -> some View {
        content
            .sheet(isPresented: $showComposer) {
                composer
            }
            .confirmationDialog("Cannot open iOS Mail!", isPresented: $showFailOptions, titleVisibility: .visible, actions: onFail)
            .onChange(of: isShowing) { newValue in
                if newValue == true {
                    if MFMailComposeViewController.canSendMail() {
                        showComposer = true
                    } else {
                        showFailOptions = true
                    }
                    // Reset the external trigger so setting it to true again will re-run this flow
                    isShowing = false
                }
            }
    }
}

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
    
    public init(result: Binding<Result<MFMailComposeResult, any Error>?>, configure: ((MFMailComposeViewController) -> Void)? = nil) {
        self._result = result
        self.configure = configure
    }
    
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

