//
//  UILabel.swift
//  DJSwiftHelpers
//
//  Created by Darren Jones on 11/11/2020.
//  Copyright © 2020 Dappological Ltd. All rights reserved.
//

import UIKit

public
extension UILabel {
    
    enum SFSymbolPosition {
        case beginning
        case end
    }
    
    /**
     Adds an SFSymbol to the start of the label text
     - Parameters:
        - named: The SFSymbol name
     */
    @available(iOS 13.0, *)
    func addSFSymbol(named:String, position:UILabel.SFSymbolPosition = .beginning, fontWeight weight:UIFont.Weight = .bold, fontDescriptorDesign design:UIFontDescriptor.SystemDesign = .rounded) {
        
        // Image needs to be the same font size as our label but should really be bold, so let's set our label font to system rounded bold.
        let fontSize = self.font.pointSize
        self.font = UIFont(descriptor: UIFont.systemFont(ofSize: fontSize, weight: weight).fontDescriptor.withDesign(design)!, size: fontSize)
        let symbolConfig = UIImage.SymbolConfiguration(font: self.font)
        // Create the image with the correct tint colour and font size
        if let image = UIImage(systemName: named, withConfiguration: symbolConfig)?.withTintColor(self.textColor)
        {
            let imageAttachment = NSTextAttachment(image: image)
            switch position {
            case .beginning:
                // Add our image to an AttributedString
                let attrString = NSMutableAttributedString(attachment: imageAttachment)
                // Add our label text
                let endAttrString = NSAttributedString(string: " \(self.text ?? "")")
                attrString.append(endAttrString)
                // Set the label string
                self.attributedText = attrString
            case .end:
                // Add our label text to an AttributedString
                let attrString = NSMutableAttributedString(string: "\(self.text ?? "") ")
                // Add our image
                let endImage = NSMutableAttributedString(attachment: imageAttachment)
                attrString.append(endImage)
                // Set the label string
                self.attributedText = attrString
            }
        }
    }
}
