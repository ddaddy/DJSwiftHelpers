//
//  UIApplication.swift
//  VibeScreen
//
//  Created by Darren Jones on 17/02/2020.
//  Copyright © 2020 Dappological Ltd. All rights reserved.
//

import UIKit

public
extension UIApplication {
    
    /**
     @brief returns the top most ViewController regardless if embeded in a navigation stack or not
     */
    class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {

        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)

        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)

        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
    
    class func displayGlobalAlert(title:String, message:String, completion: (() -> Void)? = nil) {
        
        let ac = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction.init(title: "OK", style: .cancel, handler: {
            (alert) in
            
            completion?()
        }))
        
        UIApplication.getTopViewController()?.present(ac, animated: true, completion: nil)
    }
    
    /**
     * Dismiss back to the root view controller
     */
    class func dismisstoRoot(animated:Bool, completion:(() -> Void)? = nil) {
        
        // On iOS 12, calling dismiss when there is nothing to dismiss does not call the completion block, so we have to see if we are already at base level
        guard self.shared.keyWindow?.rootViewController?.presentedViewController != nil else {
            
            // rootViewController is on top, so nothing to dismiss
            completion?()
            return
        }
        
        // We have views on top of the rootViewController
        self.shared.keyWindow?.rootViewController?.dismiss(animated: animated, completion: completion)
    }
}

public
extension UIWindow {
    
    /**
     Fetches the key window
     */
    static var key: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}
