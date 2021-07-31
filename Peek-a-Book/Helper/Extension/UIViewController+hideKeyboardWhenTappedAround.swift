//
//  UIViewController+hideKeyboardWhenTappedAround.swift
//  Peek-a-Book
//
//  Created by Yossan Sandi Rahmadi on 31/07/21.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
