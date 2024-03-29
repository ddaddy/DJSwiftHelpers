//
//  UIStackView.swift
//  Commute
//
//  Created by Darren Jones on 10/09/2020.
//  Copyright © 2020 Darren Jones. All rights reserved.
//

#if canImport(UIKit)
import UIKit

#if !os(watchOS)
@available(iOS 9.0, macCatalyst 13.1, tvOS 9.0, *)
public
extension UIStackView {
    
    /**
     Remove and dealloc all subviews from a UIStackView
     */
    func safelyRemoveArrangedSubviews() {

        // Remove all the arranged subviews and save them to an array
        let removedSubviews = arrangedSubviews.reduce([]) { (sum, next) -> [UIView] in
            self.removeArrangedSubview(next)
            return sum + [next]
        }

        // Deactive all constraints at once
        NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))

        // Remove the views from self
        removedSubviews.forEach({ $0.removeFromSuperview() })
    }
}

@available(iOS 9.0, macCatalyst 13.1, tvOS 9.0, *)
public
extension UIStackView {
    
    /**
     Add a background color to a UIStackView
     */
    func addBackground(color: UIColor) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)
    }
}
#endif
#endif
