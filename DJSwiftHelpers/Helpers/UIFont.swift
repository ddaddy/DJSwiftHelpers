//
//  UIFont.swift
//  DJSwiftHelpers
//
//  Created by Darren Jones on 03/01/2021.
//  Copyright © 2021 Dappological Ltd. All rights reserved.
//

import UIKit

@available(iOS 11.0, *)
public
extension UIFont {
    
    /**
     Allows you to specify a font weight to a dynamic font style
     - Parameters:
        - style: eg. `.title2`
        - weight: eg. `.medium`
     
     Example usage:
     ```
     label.font = UIFont.preferredFont(for: .title2, weight: .medium)
     ```
     */
    static func preferredFont(for style: TextStyle, weight: Weight) -> UIFont {
        let metrics = UIFontMetrics(forTextStyle: style)
        let desc = UIFontDescriptor.preferredFontDescriptor(withTextStyle: style)
        let font = UIFont.systemFont(ofSize: desc.pointSize, weight: weight)
        return metrics.scaledFont(for: font)
    }
}
