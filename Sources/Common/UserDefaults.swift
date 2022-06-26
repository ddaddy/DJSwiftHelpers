//
//  UserDefaults.swift
//  School Sport
//
//  Created by Darren Jones on 12/08/2020.
//  Copyright © 2020 Dappological Ltd. All rights reserved.
//

import Foundation

public
extension UserDefaults {
    
    /**
     Sets a `String` to UserDefaults or removes it if nil
     */
    func setOrDelete(value:String?, forKey key:String) {
        if (value == nil || value?.isEmpty == true)
        {
            self.removeObject(forKey: key)
        }
        else
        {
            self.set(value, forKey: key)
        }
        self.synchronize()
    }
    
    /**
    Sets an `Int` to UserDefaults or removes it if nil
    */
    func setOrDelete(value:Int?, forKey key:String) {
        if (value == nil)
        {
            self.removeObject(forKey: key)
        }
        else
        {
            self.set(value, forKey: key)
        }
        self.synchronize()
    }
}

public
extension UserDefaults {
    
    /**
     Delete all `UserDefault`'s for the containing `bundleIdentifier`
     */
    static func resetDefaults() {
        if let bundleID = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
        }
    }
}
