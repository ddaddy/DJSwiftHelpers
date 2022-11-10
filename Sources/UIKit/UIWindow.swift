//
//  UIWindow.swift
//  DJSwiftHelpers
//
//  Created by Darren Jones on 11/09/2020.
//  Copyright © 2020 Dappological Ltd. All rights reserved.
//

import UIKit

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
