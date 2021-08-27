//
//  UIViewController+showHideNavigation.swift
//  Peek-a-Book
//
//  Created by Arif Rahman on 13/08/21.
//

import Foundation
import UIKit
extension UIViewController {
    open override func awakeFromNib() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    func showNavigation(_ isShow: Bool) {
        navigationController?.setNavigationBarHidden(isShow, animated: false)
    }
}
