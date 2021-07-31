//
//  LoginContentView.swift
//  Peek-a-Book
//
//  Created by Yossan Sandi Rahmadi on 29/07/21.
//

import UIKit

@IBDesignable

class LoginContentView: UIView {
    
    @IBOutlet weak var loginContentView: UIView!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var fieldContainer: UIView!
    @IBOutlet weak var identifierTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let viewModel = LoginViewModel()
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    override func awakeFromNib() {
        layer.cornerRadius = 36
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        clipsToBounds = true
    }
    
    func commonInit() {
        loginContentView = loadViewFromNib(nibName: XIBConstant.LoginContentView)
        loginContentView.frame = self.bounds
        
        passwordTextField.isSecureTextEntry = true
        
        loginButton.layer.cornerRadius = 12
        loginButton.layer.applyShadow(
            color: .black,
            alpha: 0.2,
            x: 0,
            y: 3,
            blur: 10,
            spread: 0
        )
        
        fieldContainer.layer.cornerRadius = 12
        fieldContainer.layer.applyShadow(
            color: .black,
            alpha: 0.1,
            x: 0,
            y: 2,
            blur: 5,
            spread: 0
        )
        
        self.addSubview(loginContentView)
    }
    
    @IBAction func loginBtnPressed(_ sender: UIButton) {
        let identifier = identifierTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        viewModel.login(identifier: identifier, password: password)
    }
}
