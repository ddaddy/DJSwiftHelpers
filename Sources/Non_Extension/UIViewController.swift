//
//  UIViewController.swift
//  School Sport
//
//  Created by Darren Jones on 09/08/2020.
//  Copyright © 2020 Dappological Ltd. All rights reserved.
//

#if os(iOS)
import UIKit

public
extension UIViewController {
    
    /**
     Displays a `UIAlertController` with an "Ok" cancel button
     - Parameters:
        - title: Alert title
        - message: Alert message
     */
    func displayAlert(title:String?, message:String?) {
        
        displayAlert(title: title, message: message, buttonAction: nil)
    }
    
    /**
     Displays a `UIAlertController` with an "Ok" cancel button and completion block for `Ok` button
     - Parameters:
        - title: Alert title
        - message: Alert message
        - buttonAction: Closure that fires when the `Ok` button is pressed
     */
    func displayAlert(title:String?, message:String?, buttonAction:((UIAlertAction)->())?) {
        
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "Ok", style: .cancel, handler: buttonAction))
        present(alert, animated: true, completion: nil)
    }
}

public
extension UIViewController {
    
    /**
     Adds a `UIViewController` as a child controller of a `UIView`
     - Parameters:
        - child: The `UIViewController` subclass you wish to add
        - containerView: The `UIView` to add the view controller too
     
     Pins the view controller to each edge of the container view.
     */
    func addChild(_ child: UIViewController, in containerView: UIView) {
        
        guard containerView.isDescendant(of: view) else { return }
        
        addChild(child)
        containerView.addSubview(child.view)
        child.view.pinToSuperview()
        child.didMove(toParent: self)
    }
    
    /**
     Removes an embeded `UIViewController` from it's container view
     - Parameters:
        - child: The `UIViewController` to remove
     */
    func removeChild(_ child: UIViewController) {
        
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
}
#endif // os(iOS)
