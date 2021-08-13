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
    
    var viewModel: LoginViewModel?
    
    func initViewModel(_ viewModel: LoginViewModel) {
        self.viewModel = viewModel
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    override func awakeFromNib() {
        setupCornerRadius()
        
        setupTextFieldDelegate()
    }
    
    private func setupCornerRadius() {
        layer.cornerRadius = 36
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        clipsToBounds = true
    }
    
    private func setupTextFieldDelegate() {
        identifierTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    private func commonInit() {
        loginContentView = loadViewFromNib(nibName: XIBConstant.LoginContentView)
        loginContentView.frame = self.bounds
        
        setupLoginButton()
        
        setupFieldContainer()
        
        self.addSubview(loginContentView)
    }
    
    private func setupLoginButton() {
        loginButton.layer.cornerRadius = 12
        loginButton.layer.applyShadow(
            color: .black,
            alpha: 0.2,
            x: 0,
            y: 3,
            blur: 10,
            spread: 0
        )
    }
    
    private func setupFieldContainer() {
        fieldContainer.layer.cornerRadius = 12
        fieldContainer.layer.applyShadow(
            color: .black,
            alpha: 0.1,
            x: 0,
            y: 2,
            blur: 5,
            spread: 0
        )
    }
    
    private func processLogin() {
        let identifier = identifierTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        viewModel?.login(identifier: identifier, password: password)
    }
    
    @IBAction func loginBtnPressed(_ sender: UIButton) {
        processLogin()
    }
    
    @IBAction func registerBtnPressed(_ sender: UIButton) {
        viewModel?.buttonRegisterPressed.onNext(true)
    }
    
}

extension LoginContentView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == identifierTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            textField.resignFirstResponder()
            processLogin()
        } else {
            textField.resignFirstResponder()
        }
        
        return true
    }
}
