//
//  URLResponse.swift
//  DJSwiftHelpers
//
//  Created by Darren Jones on 11/11/2020.
//  Copyright © 2020 Dappological Ltd. All rights reserved.
//

import Foundation

public
extension URLResponse {
    
    /**
     Returns the HTTP status code
     */
    func statusCode() -> Int? {
        if let httpResponse = self as? HTTPURLResponse {
            return httpResponse.statusCode
        }
        return nil
    }
}
