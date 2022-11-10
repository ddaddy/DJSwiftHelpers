//
//  UIDevice.swift
//  DJHomeShortcuts
//
//  Created by Darren Jones on 06/08/2020.
//  Copyright © 2020 Dappological Ltd. All rights reserved.
//

#if canImport(UIKit)
import UIKit

#if !os(watchOS)
@available(iOS 2.0, macCatalyst 13.1, tvOS 9.0, *)
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
#endif
#endif
