//
//  UIApplication.swift
//  VibeScreen
//
//  Created by Darren Jones on 17/02/2020.
//  Copyright © 2020 Dappological Ltd. All rights reserved.
//

#if canImport(UIKit)
import UIKit

#if !os(watchOS)
@available(iOS 2.0, macCatalyst 13.1, tvOS 9.0, *)
public
extension UIApplication {
    
    /**
     Returns the top most ViewController regardless if embeded in a navigation stack or not
     */
    class func getTopViewController(base: UIViewController? = UIWindow.key?.rootViewController) -> UIViewController? {

        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)

        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)

        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
    
    /**
     Display an alert regardless of what's on the screen
     */
    class func displayGlobalAlert(title:String, message:String, completion: (() -> Void)? = nil) {
        
        let ac = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction.init(title: "OK", style: .cancel, handler: {
            (alert) in
            
            completion?()
        }))
        
        UIApplication.getTopViewController()?.present(ac, animated: true, completion: nil)
    }
    
    /**
     Dismiss back to the root view controller
     */
    class func dismisstoRoot(animated:Bool, completion:(() -> Void)? = nil) {
        
        // On iOS 12, calling dismiss when there is nothing to dismiss does not call the completion block, so we have to see if we are already at base level
        guard UIWindow.key?.rootViewController?.presentedViewController != nil else {
            
            // rootViewController is on top, so nothing to dismiss
            completion?()
            return
        }
        
        // We have views on top of the rootViewController
        UIWindow.key?.rootViewController?.dismiss(animated: animated, completion: completion)
    }
}
#endif
#endif
