//
//  InsertBookToLenderCatalogueViewController.swift
//  Peek-a-Book
//
//  Created by Gede Wicaksana on 30/07/21.
//

import UIKit

class InsertBookToLenderCatalogueViewController: UIViewController {

    @IBOutlet weak var judulBukuTextField: UITextField!
    @IBOutlet weak var nomerISBNBukuTextField: UITextField!
    @IBOutlet weak var hargaSewaBukuTextField: UITextField!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
    }
    
    func setNavigationBar(){
        self.navigationItem.title = "Tambah Buku"
        
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "DM Serif Text", size: 19)!]
        
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "DM Serif Text", size: 19.0)!], for: .normal)
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
  

    @IBAction func kondisiBukuTapped(_ sender: UITapGestureRecognizer) {
    }
    
    
    @IBAction func genreBukuTapped(_ sender: UITapGestureRecognizer) {
    }
    
 

}
