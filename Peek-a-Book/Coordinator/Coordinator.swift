//
//  Coordinator.swift
//  Peek-a-Book
//
//  Created by Yossan Sandi Rahmadi on 26/07/21.
//

import UIKit

protocol FlowCoordinator: AnyObject {
    var parentCoordinator: MainBaseCoordinator? { get set }
}

protocol Coordinator: FlowCoordinator {
    var rootViewController: UIViewController { get set }
    func start() -> UIViewController
    @discardableResult func resetToRoot() -> Self
}

extension Coordinator {
    var navigationRootViewController: UINavigationController? {
        get {
            (rootViewController as? UINavigationController)
        }
    }
    
    func resetToRoot() -> Self {
        navigationRootViewController?.popToRootViewController(animated: false)
        return self
    }
}
