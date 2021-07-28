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
        
        let booksVC = UINavigationController(rootViewController: BooksViewController())
        booksVC.tabBarItem = UITabBarItem(title: "Books", image: UIImage(systemName: "book.fill"), tag: 0)
        
        let profileVC = UINavigationController(rootViewController: ProfileViewController())
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle.fill"), tag: 1)
        
        self.viewControllers = [booksVC, profileVC]
    }
    
}
