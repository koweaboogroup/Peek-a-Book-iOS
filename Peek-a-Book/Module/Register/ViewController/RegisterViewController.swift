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
    
    @IBOutlet weak var termsAndConditionsBottomConstraint: NSLayoutConstraint!
    
    private let viewModel = RegisterViewModel()
    private var addressViewModel = AddressViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Buat Akun Penyewaanmu"
        setupUI()
        setupRx()
        self.setupKeyboardListener(selector: #selector(handleKeyboardNotification))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @objc func handleKeyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let keyboardFrameValue = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)
            let keyboardFrame = keyboardFrameValue?.cgRectValue

            let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification

            termsAndConditionsBottomConstraint.constant = isKeyboardShowing ? keyboardFrame!.height - keyboardFrame!.height * 0.2 : 20
            
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func registerBtnPressed(_ sender: UIButton) {
        processRegister()
    }
    
    @IBAction func alamatBtnPressed(_ sender: Any) {
        let vc = ModuleBuilder.shared.goToAlamatViewController()
        vc.initViewModel(viewModel: addressViewModel)
        self.navigationController?.pushViewController(vc, animated: true)
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
        
        viewModel.isAllTextFieldFilled()
            .bind(to: registerButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        viewModel.isAllTextFieldFilled()
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
        
        nameTextField.delegate = self
        emailTextField.delegate = self
        whatsappNumberTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    private func processRegister() {
        var alert: UIAlertController?
        
        let name = nameTextField.text?.trimmingCharacters(in: .whitespaces) ?? ""
        
        let email = emailTextField.text?.trimmingCharacters(in: .whitespaces) ?? ""
        
        let whatsappNumber = whatsappNumberTextField.text?.trimmingCharacters(in: .whitespaces) ?? ""
        
        let password = passwordTextField.text?.trimmingCharacters(in: .whitespaces) ?? ""
        
        let confirmPassword = confirmPasswordTextField.text?.trimmingCharacters(in: .whitespaces) ?? ""
        
        if !email.isValid(.email) {
            alert = setupAlert(errorValidationType: .email)
        } else if !whatsappNumber.isValid(.phoneNumber) {
            alert = setupAlert(errorValidationType: .whatsappNumber)
        } else if !password.isValid(.password) {
            alert = setupAlert(errorValidationType: .password)
        } else if password != confirmPassword {
            alert = setupAlert(errorValidationType: .passwordConfirmation)
        }
        
        if alert != nil {
            present(alert ?? UIAlertController(), animated: true, completion: nil)
            return
        }
        
        print("berhasil register")
        
    }
    
    private func setupAlert(errorValidationType: RegisterErrorValidationType) -> UIAlertController {
        let alert = UIAlertController(title: errorValidationType.getTitle(), message: errorValidationType.getMessage(), preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Baik", style: .default, handler: { action in
            switch errorValidationType {
            case .email: self.emailTextField.becomeFirstResponder()
            case .whatsappNumber: self.whatsappNumberTextField.becomeFirstResponder()
            case .password: self.passwordTextField.becomeFirstResponder()
            case .passwordConfirmation: self.confirmPasswordTextField.becomeFirstResponder()
            }
        }))
        
        return alert
    }
    
    @IBAction func termsAndConditionsButtonPressed(_ sender: UIButton) {
        let safariViewController = SFSafariViewController(url: URL(string: Constant.termsAndConditionsLink) ?? URL(fileURLWithPath: ""))
        
        self.present(safariViewController, animated: true, completion: nil)
    }
}

extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == whatsappNumberTextField {
            if let whatsappNumber = whatsappNumberTextField.text?.trimmingCharacters(in: .whitespaces) {
                let fixedWhatsappNumber = whatsappNumber.filter {
                    !$0.isWhitespace
                }
                
                whatsappNumberTextField.text = fixedWhatsappNumber
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField {
            emailTextField.becomeFirstResponder()
        } else if textField == emailTextField {
            whatsappNumberTextField.becomeFirstResponder()
        } else if textField == whatsappNumberTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            confirmPasswordTextField.becomeFirstResponder()
        }
        
        return true
    }
}

extension RegisterViewController {
    enum RegisterErrorValidationType {
        case email
        case whatsappNumber
        case password
        case passwordConfirmation
        
        func getTitle() -> String {
            switch self {
            case .email:
                return "Format Email Salah"
            case .whatsappNumber:
                return "Format Nomor Whatsapp Salah"
            case .password:
                return "Format Password Salah"
            case .passwordConfirmation:
                return "Password Belum Sesuai"
            }
        }
        
        func getMessage() -> String {
            switch self {
            case .email:
                return "Mohon isi alamat email dengan benar"
            case .whatsappNumber:
                return "Mohon isi nomor whatsapp dengan benar"
            case .password:
                return "Password antara 6 - 32 karakter dengan minimal satu digit angka"
            case .passwordConfirmation:
                return "Isi ulang konfirmasi password Anda"
            }
        }
    }
}
