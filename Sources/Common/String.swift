//
//  String.swift
//  Commute
//
//  Created by Darren Jones on 09/09/2020.
//  Copyright © 2020 Darren Jones. All rights reserved.
//

import Foundation

public
extension String {
    
    enum TruncationPosition {
        case head
        case middle
        case tail
    }
    
    /**
    Truncates a string by removing all characters at the `position`
    - Parameters:
       - limit: How many characters to truncate
       - position: `.head` `.middle` or `.tail`. Default is `.tail`
       - leader: A string added at the position, eg `...`. Default is empty
    */
    func truncated(limit: Int, position: TruncationPosition = .tail, leader: String = "") -> String {
        guard self.count > limit else { return self }

        switch position {
        case .head:
            return leader + self.suffix(limit)
        case .middle:
            let headCharactersCount = Int(ceil(Float(limit - leader.count) / 2.0))

            let tailCharactersCount = Int(floor(Float(limit - leader.count) / 2.0))
            
            return "\(self.prefix(headCharactersCount))\(leader)\(self.suffix(tailCharactersCount))"
        case .tail:
            return self.prefix(limit) + leader
        }
    }
    
    /**
     Deletes a prefix string if it exists
     - Parameters:
        - prefix: The string to match and delete if it exists at the beginning of a `String`
     */
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        
        return String(self.dropFirst(prefix.count))
    }
}

public
extension String {
    
    /**
    Allows you to use [8] subscript to get 1 character from a String
    */
    subscript(_ i: Int) -> String {
        let idx1 = index(startIndex, offsetBy: i)
        let idx2 = index(idx1, offsetBy: 1)
        return String(self[idx1..<idx2])
    }
    
    /**
    Allows you to use [0..<9] subscript to truncate a String
    */
    subscript (r: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound)
        return String(self[start ..< end])
    }
    
    /**
    Allows you to use [0...8] subscript to truncate a String
    */
    subscript (r: CountableClosedRange<Int>) -> String {
        let startIndex =  self.index(self.startIndex, offsetBy: r.lowerBound)
        let endIndex = self.index(startIndex, offsetBy: r.upperBound - r.lowerBound)
        return String(self[startIndex...endIndex])
    }
}

public
extension String {
    
    /**
    Converts a String into a Bool by looking for the relevant type texts (Yes, No, True etc..)
    */
    var bool: Bool? {
        switch self.lowercased() {
        case "true", "t", "yes", "y", "1":
            return true
        case "false", "f", "no", "n", "0":
            return false
        default:
            return nil
        }
    }
    
    /**
     Converts a String into a Double
     */
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
}

public
extension String {
    
    /**
     Converts a String to Data then saves it to the given URL path
     */
    func save(path:URL) -> Bool {
        
        let data = self.data(using: .utf8)
        let path = path
        guard let _ = try? data?.write(to: path) else {
            print("Failed to write \(path)")
            return false
        }
        return true
    }
}

public
extension StringProtocol {
    
    func index<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
        range(of: string, options: options)?.lowerBound
    }
    
    func endIndex<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
        range(of: string, options: options)?.upperBound
    }
    
    func indices<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Index] {
        var indices: [Index] = []
        var startIndex = self.startIndex
        while startIndex < endIndex,
            let range = self[startIndex...]
                .range(of: string, options: options) {
                    indices.append(range.lowerBound)
                    startIndex = range.lowerBound < range.upperBound ? range.upperBound :
                        index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return indices
    }
    
    func ranges<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Range<Index>] {
        var result: [Range<Index>] = []
        var startIndex = self.startIndex
        while startIndex < endIndex,
            let range = self[startIndex...]
                .range(of: string, options: options) {
                    result.append(range)
                    startIndex = range.lowerBound < range.upperBound ? range.upperBound :
                        index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return result
    }
}

public
extension StringProtocol {
    
    /**
     Splits a string into an array of lines
     */
    var lines: [SubSequence] { split(whereSeparator: \.isNewline) }
}

public
extension String {
    
    /**
     Returns a string that appears between 2 strings
     - Parameters:
        - from: The first string to find
        - to: The string to scan up to
     
     If `from` or `to` are `nil`, it will return from start or up to end of string
     */
    func slice(from: String? = nil, to: String? = nil) -> String? {
        var rangeFrom = range(of: from ?? "%$£somethingthatshouldntappearinthestring£$%")?.upperBound
        if (from == nil) { rangeFrom = startIndex }
        guard let rangeFrom = rangeFrom else { return nil }
        
        var rangeTo = self[rangeFrom...].range(of: to ?? "%$£somethingthatshouldntappearinthestring£$%")?.lowerBound
        if (to == nil) { rangeTo = endIndex }
        guard let rangeTo = rangeTo else { return nil }
        
        return String(self[rangeFrom..<rangeTo])
    }
}
