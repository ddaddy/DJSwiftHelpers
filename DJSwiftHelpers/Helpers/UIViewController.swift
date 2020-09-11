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
     */
    func displayAlert(title:String, message:String) {
        
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
