//
//  ConfirmationDialog.swift
//  Peek-a-Book
//
//  Created by Arif Rahman on 02/08/21.
//

import Foundation
import UIKit
class ConfirmationDialog {
    static func showAlertNegative(viewController: UIViewController, title: String, subtitle: String, positiveText: String, negativeText: String, positiveCompletion: @escaping () -> Void, negativeCompletion: @escaping () -> Void){
        let alert = UIAlertController(
            title: title,
            message: subtitle,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: positiveText, style: .default) { _ in
            positiveCompletion()
        })

        alert.addAction(UIAlertAction(title: negativeText, style: .destructive) { _ in
            negativeCompletion()
        })
        
        viewController.present(alert, animated: true)
    }

    static func showAlertPositive(viewController: UIViewController, title: String, subtitle: String, positiveText: String, negativeText: String, positiveCompletion: @escaping () -> Void, negativeCompletion: @escaping () -> Void){
        let alert = UIAlertController(
            title: title,
            message: subtitle,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: negativeText, style: .default) { _ in
            negativeCompletion()
        })

        alert.addAction(UIAlertAction(title: positiveText, style: .default) { _ in
            positiveCompletion()
        })

        viewController.present(alert, animated: true)
    }

    static func showInfoAlert(viewController: UIViewController, title: String, subtitle: String, text: String, completion: @escaping () -> Void){
        let alert = UIAlertController(
            title: title,
            message: subtitle,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: text, style: .cancel) { _ in
            completion()
        })
        viewController.present(alert, animated: true)
    }
}
