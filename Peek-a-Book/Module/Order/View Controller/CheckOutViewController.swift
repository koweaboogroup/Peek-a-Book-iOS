//
//  CheckOutViewController.swift
//  Peek-a-Book
//
//  Created by Gede Wicaksana on 04/08/21.
//

import UIKit

class CheckOutViewController: UIViewController {

    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        // Do any additional setup after loading the view.
    }


    func setNavigationBar(){
        self.navigationItem.title = "Keranjang"
        
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "DM Serif Text", size: 19)!]
        
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "DM Serif Text", size: 19.0)!], for: .normal)
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }

}
