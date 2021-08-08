//
//  UIView+Corner.swift
//  Peek-a-Book
//
//  Created by Arif Rahman on 29/07/21.
//

import Foundation
import UIKit
extension UIView {
    func cornerRadius(_ value: CGFloat) {
        self.layer.cornerRadius = value
        self.layer.masksToBounds = true
    }
    func cornerRadiusTop(_ value: CGFloat) {
        self.layer.cornerRadius = value
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    func cornerRadiusBottom(_ value: CGFloat) {
        self.layer.cornerRadius = value
        self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
}
