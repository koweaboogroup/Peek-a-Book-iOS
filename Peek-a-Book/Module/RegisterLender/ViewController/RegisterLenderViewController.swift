//
//  RegisterLenderViewController.swift
//  Peek-a-Book
//
//  Created by Arif Rahman on 01/08/21.
//

import UIKit

class RegisterLenderViewController: UIViewController {

    @IBOutlet weak var circleImageView: CircleImageView!
    
    @IBOutlet weak var buttonRegisterLender: UIButton!
    @IBOutlet weak var registerContentView: RegisterContentView!
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        // Do any additional setup after loading the view.
    }

    private func setupView(){
        self.navigationItem.title = "Buka Penyewaan"

        registerContentView.cornerRadius(10)
        registerContentView.layer.applyShadow(
            color: .black,
            alpha: 0.1,
            x: 0,
            y: 2,
            blur: 5,
            spread: 0
        )
        buttonRegisterLender.cornerRadius(10)
    }
}
