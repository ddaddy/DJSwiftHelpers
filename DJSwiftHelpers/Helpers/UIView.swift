//
//  UIView.swift
//  DJSwiftHelpers
//
//  Created by Darren Jones on 15/06/2021.
//  Copyright © 2021 Dappological Ltd. All rights reserved.
//

import UIKit

public
extension UIView {
    
    /**
     Sets autlayout constraints on a view with an optional inset.
     - Parameters:
        - insets: `UIEdgeInsets` to apply to the view. Defaults to `.zero`
        - edges: A `UIRectEdge` specifying which edges to pin (`.top`, `.bottom`, `.left`, `.right`) Defaults to `.all`
     
     Be sure to first add the view before calling `pinToSuperview`.
     */
    func pinToSuperview(with insets: UIEdgeInsets = .zero, edges: UIRectEdge = .all) {
        
        guard let superview = superview else { return }
        
        translatesAutoresizingMaskIntoConstraints = false
        if edges.contains(.top) {
            topAnchor.constraint(equalTo: superview.topAnchor, constant: insets.top).isActive = true
        }
        if edges.contains(.bottom) {
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -insets.bottom).isActive = true
        }
        if edges.contains(.left) {
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: insets.left).isActive = true
        }
        if edges.contains(.right) {
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -insets.right).isActive = true
        }
    }
}
