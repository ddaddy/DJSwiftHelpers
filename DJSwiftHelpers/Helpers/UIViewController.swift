//
//  UIViewController.swift
//  School Sport
//
//  Created by Darren Jones on 09/08/2020.
//  Copyright © 2020 Dappological Ltd. All rights reserved.
//

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
