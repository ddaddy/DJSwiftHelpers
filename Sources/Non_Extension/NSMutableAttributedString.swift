//
//  NSMutableAttributedString.swift
//  DJSwiftHelpers
//
//  Created by Darren Jones on 09/10/2022.
//  Copyright © 2022 Dappological Ltd. All rights reserved.
//

#if os(iOS)
import UIKit

#if !IS_EXTENSION
public
extension NSMutableAttributedString {
    
    /**
     Change the colour of text within an `NSMutableAttributedString`
     - Parameters:
        - textToFind: The text that you want to colour
        - withColour: The `UIColor` you want to colour the text
     */
    func setColorForText(textToFind: String, withColor color: UIColor) {
        let range: NSRange = self.mutableString.range(of: textToFind, options: .caseInsensitive)
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
    }
}
#endif // !IS_EXTENSION
#endif // os(iOS)
