//
//  EditProfileLenderViewController.swift
//  Peek-a-Book
//
//  Created by Arif Rahman on 03/08/21.
//

import UIKit

class EditProfileLenderViewController: UIViewController {

    @IBOutlet weak var circleImageView: CircleImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var fieldName: CustomTextField!
    @IBOutlet weak var fieldEmail: CustomTextField!
    @IBOutlet weak var fieldWA: CustomTextField!
    @IBOutlet weak var fieldPassword: CustomTextField!
    @IBOutlet weak var fieldConfirmPassword: CustomTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
    }
    
    private func setupView(){
        containerView.cornerRadius(10)
        containerView.borderColor = #colorLiteral(red: 0.7450238466, green: 0.7451503873, blue: 0.7536143064, alpha: 1)
        containerView.borderWidth = 1
        
        fieldName.setTitleLabel("Nama")
        fieldEmail.setTitleLabel("Email")
        fieldWA.setTitleLabel("No Whatsapp")
        fieldPassword.setTitleLabel("Password")
        fieldConfirmPassword.setTitleLabel("Konfirmasi Password")
        
        fieldPassword.isPassword(true)
        fieldConfirmPassword.isPassword(true)
        
    }
}
