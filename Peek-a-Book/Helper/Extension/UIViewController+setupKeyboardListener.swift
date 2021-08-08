//
//  UIKit+setupKeyboardListener.swift
//  Peek-a-Book
//
//  Created by Yossan Sandi Rahmadi on 05/08/21.
//

import UIKit

extension UIViewController {
    func setupKeyboardListener(selector: Selector) {
        NotificationCenter.default.addObserver(self, selector: selector, name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: selector, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
