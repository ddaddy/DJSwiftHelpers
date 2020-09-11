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
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}
