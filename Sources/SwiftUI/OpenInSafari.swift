//
//  OpenInSafari.swift
//  DJSwiftHelpers
//
//  Created by Darren Jones on 05/11/2022.
//  Copyright © 2022 Dappological Ltd. All rights reserved.
//

#if canImport(SwiftUI)
#if os(iOS)
// SwiftUI isn't available in the armv7 architecture
#if arch(arm64) || arch(x86_64)
import UIKit
import SwiftUI

/**
 A SwiftUI view to display the share sheet with `Open in Safari`
 
    - isPresented: A `Binding` for a bool that makes the view appear when switched to `true`
    - url: The `URL` you want to share through the share sheet
 
 Use it by adding it to the background of a view like this:
 ```
 .background(
    // Share button action
    SafariActivityView(isPresented: $activityPresented, url: url)
 )
 ```
 */
@available(iOS 13, *)
public
struct SafariActivityView: UIViewControllerRepresentable {
    @Binding public var isPresented: Bool
    public var url: URL
    
    public init(isPresented: Binding<Bool>, url: URL) {
        
        self._isPresented = isPresented
        self.url = url
    }
    
    public func makeUIViewController(context: Context) -> UIViewController {
        UIViewController()
    }
    
    public func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
        let activity = SafariActivity()
        let activityViewController = UIActivityViewController(activityItems: [url], applicationActivities: [activity])
        
        if isPresented && uiViewController.presentedViewController == nil {
            uiViewController.present(activityViewController, animated: true)
        }
        
        activityViewController.completionWithItemsHandler = { (_, _, _, _) in
            isPresented = false
        }
    }
}

/**
 A `UIActivity` that adds an `Open in Safari` activity to a share sheet.
 */
@available(iOS 13, *)
private
class SafariActivity: UIActivity {
    
    public var url: URL?
    
    public override var activityType: UIActivity.ActivityType? {
        return UIActivity.ActivityType(rawValue: "SafariActivity")
    }
    
    public override var activityTitle: String? {
        // load value from main bundle to enable overwriting title
        // NOTE: This won't actually localize with the bundle from a project that adds this Framework
        let frameworkBundle = Bundle(for: type(of: self))
        let mainBundle = Bundle.main
        let defaultString = frameworkBundle.localizedString(forKey: "Open in Safari", value: "Open in Safari", table: nil)
        return mainBundle.localizedString(forKey: "Open in Safari", value: defaultString, table: nil)
    }
    
    public override var activityImage: UIImage? {
        return UIImage(systemName: "safari")
    }
    
    public override func canPerform(withActivityItems activityItems: [Any]) -> Bool {
        var canPerform = false
        
        for activityItem in activityItems {
            if let URL = activityItem as? URL {
                if UIApplication.shared.canOpenURL(URL) {
                    canPerform = true
                    break
                }
            }
        }
        
        return canPerform
    }
    
    public override func prepare(withActivityItems activityItems: [Any]) {
        for activityItem in activityItems {
            if let URL = activityItem as? URL {
                self.url = URL
                break
            }
        }
    }
    
    public override func perform() {
        
        if let url = url {
            UIApplication.shared.open(url, options: [:], completionHandler: { completed in
                self.activityDidFinish(completed)
            })
        } else {
            activityDidFinish(false)
        }
    }
}
#endif // arch(arm64) || arch(x86_64)
#endif // os(iOS)
#endif // canImport(SwiftUI)
