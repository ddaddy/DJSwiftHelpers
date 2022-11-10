//
//  Gradient.swift
//  DJSwiftHelpers
//
//  Created by Darren Jones on 12/11/2021.
//  Copyright © 2021 Dappological Ltd. All rights reserved.
//

#if canImport(UIKit)
import UIKit

/**
 A `UIView` subclass with a gradient background.
 Can be used in Storyboards too.
 
 Requires a subclass in your project if you want to use IBDesignable
 ```
 @IBDesignable
 class GradientView: Gradient {
     @IBInspectable override var startColor: UIColor {get { return super.startColor }set { super.startColor = newValue }}
     @IBInspectable override var endColor: UIColor {get { return super.endColor }set { super.endColor = newValue }}
     @IBInspectable override var startLocation: Double {get { return super.startLocation }set { super.startLocation = newValue }}
     @IBInspectable override var endLocation: Double {get { return super.endLocation }set { super.endLocation = newValue }}
     @IBInspectable override var horizontalMode: Bool {get { return super.horizontalMode }set { super.horizontalMode = newValue }}
     @IBInspectable override var diagonalMode: Bool {get { return super.diagonalMode }set { super.diagonalMode = newValue }}
 }
 ```
 */
#if !os(watchOS)
@available(iOS 2.0, macCatalyst 13.1, tvOS 9.0, *)
@IBDesignable
open class Gradient: UIView {
    @IBInspectable open var startColor:   UIColor = .black { didSet { updateColors() }}
    @IBInspectable open var endColor:     UIColor = .white { didSet { updateColors() }}
    @IBInspectable open var startLocation: Double =   0.05 { didSet { updateLocations() }}
    @IBInspectable open var endLocation:   Double =   0.95 { didSet { updateLocations() }}
    @IBInspectable open var horizontalMode:  Bool =  false { didSet { updatePoints() }}
    @IBInspectable open var diagonalMode:    Bool =  false { didSet { updatePoints() }}

    override public class var layerClass: AnyClass { CAGradientLayer.self }

    var gradientLayer: CAGradientLayer { layer as! CAGradientLayer }

    func updatePoints() {
        if horizontalMode {
            gradientLayer.startPoint = diagonalMode ? .init(x: 1, y: 0) : .init(x: 0, y: 0.5)
            gradientLayer.endPoint   = diagonalMode ? .init(x: 0, y: 1) : .init(x: 1, y: 0.5)
        } else {
            gradientLayer.startPoint = diagonalMode ? .init(x: 0, y: 0) : .init(x: 0.5, y: 0)
            gradientLayer.endPoint   = diagonalMode ? .init(x: 1, y: 1) : .init(x: 0.5, y: 1)
        }
    }
    func updateLocations() {
        gradientLayer.locations = [startLocation as NSNumber, endLocation as NSNumber]
    }
    func updateColors() {
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }
    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updatePoints()
        updateLocations()
        updateColors()
    }
}
#endif
#endif
