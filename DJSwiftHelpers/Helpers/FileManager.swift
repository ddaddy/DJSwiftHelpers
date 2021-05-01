//
//  FileManager.swift
//  DJSwiftHelpers
//
//  Created by Darren Jones on 26/04/2021.
//  Copyright © 2021 Dappological Ltd. All rights reserved.
//

import Foundation

public
extension FileManager {
    
    /**
     Fetches all contents (files & folders) in a specified file path and all subfolders
     - Parameters:
        - path: A `String` representing the file path to search
     - Returns: An array of `URL`'s
     */
    func allContents(path: String) -> [URL] {

        let baseurl: URL = URL(fileURLWithPath: path)
        var urls = [URL]()
        enumerator(atPath: path)?.forEach({ (e) in
            guard let s = e as? String else { return }

            let relativeURL = URL(fileURLWithPath: s, relativeTo: baseurl)
            let url = relativeURL.absoluteURL
            urls.append(url)
        })

        return urls
    }
    
    /**
     Fetch contents (files & folders) in a specifies file path, none recursive
     - Parameters:
        - directory: A `FileManager.SearchPathDirectory` to search, eg. `.documentDirectory`
        - skipsHiddenFiles: A `Bool` that indicates whether to skip hidden files
     - Returns: An array of `URL`'s
     */
    func urls(for directory: FileManager.SearchPathDirectory, skipsHiddenFiles: Bool = true ) -> [URL]? {

        let documentsURL = urls(for: directory, in: .userDomainMask)[0]
        return urls(for: documentsURL)
    }
    
    /**
     Fetch contents (files & folders) in a specifies file path, none recursive
     - Parameters:
        - directory: A file `URL` to search
        - skipsHiddenFiles: A `Bool` that indicates whether to skip hidden files
     - Returns: An array of `URL`'s
     */
    func urls(for directory: URL, skipsHiddenFiles: Bool = true ) -> [URL]? {

        let fileURLs = try? contentsOfDirectory(at: directory, includingPropertiesForKeys: nil, options: skipsHiddenFiles ? .skipsHiddenFiles : [] )
        return fileURLs
    }
    
    /**
     Parse a `json` file into the specified object type
     - Parameters:
        - fileURL: A file `URL` for the file to read and parse
        - type: An object type that is created from the json. eg. `[People].self`
     - Returns: The object type specified
     */
    func readJSONFromFile<T: Decodable>(fileURL: URL, type: T.Type) -> T? {
        
        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(T.self, from: data)
            return jsonData
        }
        catch
        {
            print("error:\(error)")
        }
        return nil
    }
}
