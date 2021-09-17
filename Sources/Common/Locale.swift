//
//  Locale.swift
//  DJSwiftHelpers
//
//  Created by Denis Martin-Bruillot on 17/09/2021.
//  Copyright © 2021 Darren Jones. All rights reserved.

import Foundation

public
extension Locale {
    
    /**
     Return the emoji flag for the given Locale
     */
    var emojiFlag: String {
        let base : UInt32 = 127397
        var s = ""
        let country = regionCode?.uppercased() ?? languageCode ?? "US"
        for v in country.unicodeScalars {
            s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return String(s)
    }
    
}
