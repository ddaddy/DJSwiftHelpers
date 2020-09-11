//
//  UIImage.swift
//  DJHomeShortcuts
//
//  Created by Darren Jones on 06/08/2020.
//  Copyright © 2020 Dappological Ltd. All rights reserved.
//

import UIKit

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
}

public
extension UIImage {
    
    func resize(width: CGFloat) -> UIImage {
        let height = (width/self.size.width)*self.size.height
        return self.resize(size: CGSize(width: width, height: height))
    }
    
    func resize(height: CGFloat) -> UIImage {
        let width = (height/self.size.height)*self.size.width
        return self.resize(size: CGSize(width: width, height: height))
    }
    
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
