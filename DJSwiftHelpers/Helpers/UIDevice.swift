//
//  UIDevice.swift
//  DJHomeShortcuts
//
//  Created by Darren Jones on 06/08/2020.
//  Copyright © 2020 Dappological Ltd. All rights reserved.
//

#if os(iOS)
import UIKit

public
extension UIDevice {
    
    class var isPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
    
    class var isPad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    
    class var isTV: Bool {
        return UIDevice.current.userInterfaceIdiom == .tv
    }
    
    class var isCarPlay: Bool {
        return UIDevice.current.userInterfaceIdiom == .carPlay
    }
}
#endif // os(iOS)
