//
//  RentViewController.swift
//  Peek-a-Book
//
//  Created by Muhammad Rifki Wildadi on 06/08/21.
//

import UIKit
import RxSwift

class RentViewController: UIViewController {

    @IBOutlet weak var rentStatusBook: UITableView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rentStatusBook.register(UINib(nibName: XIBConstant.RentBookItemTableViewCell, bundle: nil), forCellReuseIdentifier: String(describing: "RentBookItemTableViewCell"))
        
        
        //navigation
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.title = "Kelola Penyewaan"
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "DM Serif Text", size: 19)!]
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
    

}
