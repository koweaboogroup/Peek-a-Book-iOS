//
//  RootViewController.swift
//  Peek-a-Book
//
//  Created by Yossan Sandi Rahmadi on 28/07/21.
//

import UIKit

class RootViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dataManager = DataManager.shared
        
        dataManager.loadCartFromUserDefaults()
        
        let booksVC = UINavigationController(rootViewController: BooksViewController())
        booksVC.tabBarItem = UITabBarItem(title: "Books", image: UIImage(systemName: "book.fill"), tag: 0)
        
        var secondViewController: UINavigationController
        
        if dataManager.isLoggedIn() {
            secondViewController = UINavigationController(rootViewController: ProfileViewController())
        } else {
            secondViewController = UINavigationController(rootViewController: LoginViewController())
        }
        
        secondViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle.fill"), tag: 1)
        
        self.viewControllers = [booksVC, secondViewController]
    }
    
}
