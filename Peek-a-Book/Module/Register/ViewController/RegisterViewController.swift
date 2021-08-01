//
//  RegisterViewController.swift
//  Peek-a-Book
//
//  Created by Yossan Sandi Rahmadi on 01/08/21.
//

import UIKit
import RxSwift
import RxCocoa
import SafariServices

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var fieldContainer: UIView!
    
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var whatsappNumberTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    private let viewModel = RegisterViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Buat Akun Penyewaanmu"
        
        setupUI()
        setupRx()
    }
    
    @IBAction func registerBtnPressed(_ sender: UIButton) {
        print("asik")
    }
    
    private func setupRx() {
        nameTextField.rx.text
            .map {
                $0 ?? ""
            }
            .bind(to: viewModel.name)
            .disposed(by: disposeBag)
        
        emailTextField.rx.text
            .map {
                $0 ?? ""
            }
            .bind(to: viewModel.email)
            .disposed(by: disposeBag)
        
        whatsappNumberTextField.rx.text
            .map {
                $0 ?? ""
            }
            .bind(to: viewModel.whatsappNumber)
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text
            .map {
                $0 ?? ""
            }
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)
        
        confirmPasswordTextField.rx.text
            .map {
                $0 ?? ""
            }
            .bind(to: viewModel.confirmPassword)
            .disposed(by: disposeBag)
        
        viewModel.isValid()
            .bind(to: registerButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        viewModel.isValid()
            .map {
                $0 ? 1 : 0.5
            }
            .bind(to: registerButton.rx.alpha)
            .disposed(by: disposeBag)
    }
    
    private func setupUI() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        self.hideKeyboardWhenTappedAround()
        registerButton.isEnabled = false
        
        fieldContainer.layer.applyShadow(color: .black, alpha: 0.1, x: 0, y: 2, blur: 5, spread: 0)
        fieldContainer.layer.cornerRadius = 12
        
        registerButton.layer.cornerRadius = 12
        registerButton.layer.applyShadow(color: .black, alpha: 0.2, x: 0, y: 3, blur: 10, spread: 0)
    }
    
    @IBAction func termsAndConditionsButtonPressed(_ sender: UIButton) {
        let safariViewController = SFSafariViewController(url: URL(string: Constant.termsAndConditionsLink) ?? URL(fileURLWithPath: ""))
        
        self.present(safariViewController, animated: true, completion: nil)
    }
}
