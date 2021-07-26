//
//  MainCoordinator.swift
//  Peek-a-Book
//
//  Created by Yossan Sandi Rahmadi on 26/07/21.
//

import Foundation

import UIKit

enum AppFlow {
    case Books
    case Profile
}

class MainCoordinator: MainBaseCoordinator {
    var parentCoordinator: MainBaseCoordinator?
    
    lazy var rootViewController: UIViewController = UITabBarController()
    lazy var booksCoordinator: BooksBaseCoordinator = BooksCoordinator()
    lazy var profileCoordinator: ProfileCoordinator = ProfileCoordinator()
    
    func start() -> UIViewController {
        let booksVC = booksCoordinator.start()
        booksCoordinator.parentCoordinator = self
        booksVC.tabBarItem = UITabBarItem(title: "Books", image: UIImage(systemName: "book.fill"), tag: 0)
        
        let profileVC = profileCoordinator.start()
        profileCoordinator.parentCoordinator = self
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle.fill"), tag: 1)
        
        (rootViewController as? UITabBarController)?.viewControllers = [booksVC, profileVC]
                
        return rootViewController
    }
        
    func moveTo(flow: AppFlow) {
        switch flow {
        case .Books:
            (rootViewController as? UITabBarController)?.selectedIndex = 0
        case .Profile:
            (rootViewController as? UITabBarController)?.selectedIndex = 1
        }
    }
    
    func resetToRoot() -> Self {
        booksCoordinator.resetToRoot()
        moveTo(flow: .Books)
        return self
    }
    
}
