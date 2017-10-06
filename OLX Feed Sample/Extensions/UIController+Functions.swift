//
//  UIController+Functions.swift
//  OLX Feed Sample
//
//  Created by Gustavo Dario Conde on 10/6/17.
//  Copyright © 2017 Gustavo Conde. All rights reserved.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
