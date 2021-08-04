//
//  NotificationViewController.swift
//  Peek-a-Book
//
//  Created by Gede Wicaksana on 03/08/21.
//

import UIKit

class NotificationViewController: UIViewController {
    @IBOutlet weak var notificationTableView: UITableView!
    @IBOutlet weak var notificationSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setSegmentedControl()
    }
    
    func setNavigationBar(){
        self.navigationItem.title = "Notifikasi"
        
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "DM Serif Text", size: 19)!]
        
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "DM Serif Text", size: 19.0)!], for: .normal)
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
    func setSegmentedControl(){
        notificationSegmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.systemBlue], for: UIControl.State.selected)
        notificationSegmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Graphik", size: 14)!], for: .normal)
    }
    
    

}
