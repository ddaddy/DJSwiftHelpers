//
//  UIButton.swift
//  DJSwiftHelpers_UIKit
//
//  Created by Darren Jones on 13/12/2022.
//  Copyright © 2022 Dappological Ltd. All rights reserved.
//

#if canImport(UIKit)
import UIKit

#if !os(watchOS)
@available(iOS 6.0, macCatalyst 13.1, tvOS 9.0, *)
public
extension UIButton {
    
    /**
     Converts a `UIButton`'s text label to an `AttributedString` and adds an underline style to the text.
     */
    func underlineText() {
        
        guard let title = title(for: .normal) else { return }
        
        let titleString = NSMutableAttributedString(string: title)
        titleString.addAttribute(
            .underlineStyle,
            value: NSUnderlineStyle.single.rawValue,
            range: NSRange(location: 0, length: title.count)
        )
        setAttributedTitle(titleString, for: .normal)
    }
}
#endif
#endif
