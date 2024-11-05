//
//  File.swift
//  DJSwiftHelpers
//
//  Created by Darren Jones on 05/11/2024.
//

#if canImport(AppKit)
import AppKit

public
extension NSColor {
    
    /**
     Converts a hex string to a `NSColor`
     - Parameters:
        - hex: Must be a 7 or 9 digit string starting with # representing #rrggbbaa
     - Use alpha bits ff for full alpha
     */
    convenience init?(hex: String) {
        var hex = hex
        if hex.count == 7 { hex.append("FF") }
        
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let r, g, b, a: CGFloat
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

#endif
