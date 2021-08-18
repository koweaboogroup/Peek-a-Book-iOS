//
//  UIViewController+showHideNavigation.swift
//  Peek-a-Book
//
//  Created by Arif Rahman on 13/08/21.
//

import Foundation
import UIKit
extension UIViewController {
    func showNavigation(_ isShow: Bool) {
        navigationController?.setNavigationBarHidden(isShow, animated: false)
    }
}
