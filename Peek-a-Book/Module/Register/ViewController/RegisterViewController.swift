//
//  RegisterViewController.swift
//  Peek-a-Book
//
//  Created by Yossan Sandi Rahmadi on 01/08/21.
//

import UIKit
import RxSwift
import RxCocoa

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var fieldContainer: UIView!
    
    @IBOutlet weak var registerButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Buat Akun Penyewaanmu"
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        self.hideKeyboardWhenTappedAround()
        
        fieldContainer.layer.applyShadow(color: .black, alpha: 0.1, x: 0, y: 2, blur: 5, spread: 0)
        fieldContainer.layer.cornerRadius = 12
        
        registerButton.layer.cornerRadius = 12
        registerButton.layer.applyShadow(color: .black, alpha: 0.2, x: 0, y: 3, blur: 10, spread: 0)
    }

}
