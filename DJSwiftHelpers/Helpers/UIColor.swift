//
//  UIColor.swift
//  Commute
//
//  Created by Darren Jones on 10/09/2020.
//  Copyright © 2020 Darren Jones. All rights reserved.
//

#if os(iOS) || os(watchOS)
import UIKit

public
extension UIColor {
    
    /**
     Converts a hex string to a `UIColor`
     - Parameters:
        - hex: Must be a 9 digit string starting with # representing #rrggbbaa
     - Use alpha bits ff for full alpha
     */
    convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}
#endif // os(iOS) || os(watchOS)
