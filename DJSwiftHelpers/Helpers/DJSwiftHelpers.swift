//
//  DJSwiftHelpers.swift
//  DJSwiftHelpers
//
//  Created by Darren Jones on 12/11/2020.
//  Copyright © 2020 Dappological Ltd. All rights reserved.
//

import Foundation

public
struct DJSwiftHelpers {
    
    /**
     Can determine if running inside an app extension or main app
     */
    public
    static var isExtension:Bool {
        let bundleUrl: URL = Bundle.main.bundleURL
        let bundlePathExtension: String = bundleUrl.pathExtension
        let isAppex: Bool = bundlePathExtension == "appex"
        
        return isAppex
    }
}
