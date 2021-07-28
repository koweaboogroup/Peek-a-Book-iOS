//
//  BooksCoordinator.swift
//  Peek-a-Book
//
//  Created by Yossan Sandi Rahmadi on 26/07/21.
//

import UIKit

class BooksCoordinator: BooksBaseCoordinator {
    var rootViewController: UIViewController = UIViewController()
    
    var parentCoordinator: MainBaseCoordinator?
    
    func start() -> UIViewController {
        rootViewController = UINavigationController(rootViewController: BooksViewController(coordinator: self, nibName: "MapsViewController"))
        
        return rootViewController
    }
}
