//
//  UIWindow.swift
//  DJSwiftHelpers
//
//  Created by Darren Jones on 11/09/2020.
//  Copyright © 2020 Dappological Ltd. All rights reserved.
//

#if canImport(UIKit)
import UIKit

#if !os(watchOS)
@available(iOS 2.0, macCatalyst 13.1, tvOS 9.0, *)
public
extension UIWindow {
    
    /**
     Fetches the key window
     */
    static var key: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow } ??
            UIApplication.shared.connectedScenes
                   .filter({$0.activationState == .foregroundActive})
                   .map({$0 as? UIWindowScene})
                   .compactMap({$0})
                   .first?.windows
                   .filter({ $0.isKeyWindow }).first
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}
#endif
#endif
