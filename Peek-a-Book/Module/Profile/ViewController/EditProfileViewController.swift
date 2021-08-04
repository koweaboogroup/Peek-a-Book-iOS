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
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var konfirmasiPasswordTextField: UITextField!
    
  
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupRx()
    }
    
    private func setupRx() {
        let user = DataManager.shared.getUser()
        
        //contoh binding
        namaLengkapTextField.text = user?.username
        emailTextField.text = user?.email
        
    }

    @IBAction func detailAlamatGetTap(_ sender: UITapGestureRecognizer) {
        print("Pindah Ke maps")
    }
    
}
