//
//  UIImage.swift
//  DJHomeShortcuts
//
//  Created by Darren Jones on 06/08/2020.
//  Copyright © 2020 Dappological Ltd. All rights reserved.
//

#if canImport(UIKit)
import UIKit

@available(iOS 2.0, macCatalyst 13.1, tvOS 9.0, watchOS 2.0, *)
public
extension UIImage {
    
//    func resize(size: CGSize) -> UIImage {
//
//        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
//        self.draw(in: CGRect(origin: .zero, size: size))
//        let newImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return newImage!
//    }
    
    /**
     Converts a String to Data then saves it to the given URL path
     */
    func saveAsPNG(path:URL) -> Bool {
        
        let imageData = self.pngData()
        guard let _ = try? imageData?.write(to: path) else {
            print("Failed to write icon image:\(String(describing: imageData)) to path:\(path)")
            return false
        }
        return true
    }
    
    /**
     Saves a `UIImage` to the temporary directory as a `.png` and returns the URL
     - Parameters:
        - named: The filename to use (`.png` will automatically be appended)
     */
    @available(iOS 10.0, macCatalyst 13.1, tvOS 10.0, watchOS 3.0, *)
    func tempURLForImage(named name: String) -> URL? {
        
        let fileManager = FileManager.default
        let url = fileManager.temporaryDirectory.appendingPathComponent("\(name).png")
        guard self.saveAsPNG(path: url) else { return nil }
        return url
    }
}

#if !os(watchOS)
@available(iOS 2.0, macCatalyst 13.1, tvOS 9.0, *)
public
extension UIImage {
    
    @MainActor
    func resize(width: CGFloat) -> UIImage {
        let height = (width/self.size.width)*self.size.height
        return self.resize(size: CGSize(width: width, height: height))
    }
    
    @MainActor
    func resize(height: CGFloat) -> UIImage {
        let width = (height/self.size.height)*self.size.width
        return self.resize(size: CGSize(width: width, height: height))
    }
    
    @MainActor
    func resize(size: CGSize) -> UIImage {
        let widthRatio  = size.width/self.size.width
        let heightRatio = size.height/self.size.height
        var updateSize = size
        if(widthRatio > heightRatio) {
            updateSize = CGSize(width:self.size.width*heightRatio, height:self.size.height*heightRatio)
        } else if heightRatio > widthRatio {
            updateSize = CGSize(width:self.size.width*widthRatio,  height:self.size.height*widthRatio)
        }
        UIGraphicsBeginImageContextWithOptions(updateSize, false, UIScreen.main.scale)
        self.draw(in: CGRect(origin: .zero, size: updateSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}
#endif

#endif
