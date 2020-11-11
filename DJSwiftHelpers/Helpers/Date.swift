//
//  Date.swift
//  Operators
//
//  Created by Darren Jones on 10/11/2020.
//  Copyright © 2020 Darren Jones. All rights reserved.
//

import Foundation

public
extension Date {
    
    /**
     Adds additional seconds to a `Date`
     */
    func adding(seconds: Int) -> Date {
        return Calendar.current.date(byAdding: .second, value: seconds, to: self)!
    }
    
    /**
     Adds additional minutes to a `Date`
     */
    func adding(minutes: Int) -> Date {
        return Calendar.current.date(byAdding: .minute, value: minutes, to: self)!
    }
}

@available(iOS 10, *)
private
extension ISO8601DateFormatter {
    convenience init(_ formatOptions: Options, timeZone: TimeZone = TimeZone(secondsFromGMT: 0)!) {
        self.init()
        self.formatOptions = formatOptions
        self.timeZone = timeZone
    }
}

public
extension Formatter {
    
    @available(iOS 10, *)
    static let iso8601 = ISO8601DateFormatter([.withInternetDateTime])
    
    @available(iOS 11, *)
    static let iso8601withFractionalSeconds = ISO8601DateFormatter([.withInternetDateTime, .withFractionalSeconds])
}

public
extension Date {
    
    @available(iOS 10, *)
    var iso8601: String { return Formatter.iso8601.string(from: self) }
    
    @available(iOS 11, *)
    var iso8601withFractionalSeconds: String { return Formatter.iso8601withFractionalSeconds.string(from: self) }
}

public
extension String {
    
    @available(iOS 10, *)
    var iso8601: Date? { return Formatter.iso8601.date(from: self) }
    
    @available(iOS 11, *)
    var iso8601withFractionalSeconds: Date? { return Formatter.iso8601withFractionalSeconds.date(from: self) }
}
