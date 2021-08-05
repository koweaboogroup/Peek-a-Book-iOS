//
//  EditProfileViewController.swift
//  Peek-a-Book
//
//  Created by Gede Wicaksana on 29/07/21.
//

import UIKit

class EditProfileViewController: UIViewController {

    @IBOutlet weak var namaLengkapTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var noWhatsappTextField: UITextField!
    
  
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupRx()
    }
    func setNavigationBar(){
        self.navigationItem.title = "Edit Profil"
        
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "DM Serif Text", size: 19)!]
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Simpan", style: .done, target: self, action: #selector(addTapped))
        
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "DM Serif Text", size: 19.0)!], for: .normal)
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
    private func setupRx() {
        let user = DataManager.shared.getUser()
        
        //contoh binding
        namaLengkapTextField.text = user?.username
        emailTextField.text = user?.email
    }
        
    @objc func addTapped(_ sender: UINavigationItem){
        print("Simpan")
    }

    @IBAction func detailAlamatGetTap(_ sender: UITapGestureRecognizer) {
        print("Pindah Ke maps")
    }
    
}
