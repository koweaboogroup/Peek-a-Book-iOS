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
    
    // MARK: - Variable (Outlet)
    
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBOutlet weak var fieldContainer: UIView!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var whatsappNumberTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var addressDetailButton: UIButton!
    @IBOutlet weak var termsAndConditionsBottomConstraint: NSLayoutConstraint!
    
    
    // MARK: - Variable
    
    private let viewModel = RegisterViewModel()
    private var addressViewModel = AddressViewModel()
    private let disposeBag = DisposeBag()
    
    private var name = ""
    private var email = ""
    private var whatsappNumber = ""
    private var password = ""
    private var confirmPassword = ""
    
    private var address = ""
    private var urbanVillage = ""
    private var districtName = ""
    private var cityName = ""
    private var provName = ""
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Buat Akun Penyewaanmu"
        setupRx()
        setupUI()
        self.setupKeyboardListener(selector: #selector(handleKeyboardNotification))
    }
    
    // MARK: - IBAction
    
    @IBAction func registerBtnPressed(_ sender: UIButton) {
        processRegister()
    }
    
    @IBAction func addressButtonPressed(_ sender: Any) {
        goToAlamatViewController()
    }
    
    @IBAction func termsAndConditionsButtonPressed(_ sender: UIButton) {
        let safariViewController = SFSafariViewController(url: URL(string: Constant.termsAndConditionsLink) ?? URL(fileURLWithPath: ""))
        
        self.present(safariViewController, animated: true, completion: nil)
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
    
    // MARK: - Function (private)
    
    private func goToAlamatViewController() {
        let vc = ModuleBuilder.shared.goToAlamatViewController()
        vc.initViewModel(viewModel: addressViewModel)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupRx() {
        nameTextField.rx.text
            .map {
                let name = $0?.trimmingCharacters(in: .whitespaces) ?? ""
                self.name = name
                return name
            }
            .bind(to: viewModel.name)
            .disposed(by: disposeBag)
        
        emailTextField.rx.text
            .map {
                let email = $0?.trimmingCharacters(in: .whitespaces) ?? ""
                self.email = email
                return email
            }
            .bind(to: viewModel.email)
            .disposed(by: disposeBag)
        
        whatsappNumberTextField.rx.text
            .map {
                let whatsappNumber = $0?.trimmingCharacters(in: .whitespaces) ?? ""
                self.whatsappNumber = whatsappNumber
                return whatsappNumber
            }
            .bind(to: viewModel.whatsappNumber)
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text
            .map {
                let password = $0?.trimmingCharacters(in: .whitespaces) ?? ""
                self.password = password
                return password
            }
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)
        
        confirmPasswordTextField.rx.text
            .map {
                let confirmPassword = $0?.trimmingCharacters(in: .whitespaces) ?? ""
                self.confirmPassword = confirmPassword
                return confirmPassword
            }
            .bind(to: viewModel.confirmPassword)
            .disposed(by: disposeBag)
        
        addressViewModel.address
            .bind(to: addressDetailButton.rx.title(for: .normal))
            .disposed(by: disposeBag)
        
        Observable.combineLatest(viewModel.isAllTextFieldFilled(), addressViewModel.isAllAddressFieldsFilled())
            .map { registerTextFields, addressTextFields in
                return registerTextFields && addressTextFields
            }
            .bind(to: registerButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        Observable.combineLatest(viewModel.isAllTextFieldFilled(), addressViewModel.isAllAddressFieldsFilled())
            .map { registerTextFields, addressTextFields in
                return registerTextFields && addressTextFields
            }
            .map {
                $0 ? 1 : 0.5
            }
            .bind(to: registerButton.rx.alpha)
            .disposed(by: disposeBag)
        
        addressViewModel.isAllAddressFieldsFilled()
            .bind(to: addressDetailButton.rx.buttonComponentsColorFlag)
            .disposed(by: disposeBag)
        
        addressViewModel.getAllAddressFieldsObservable()
            .subscribe(onNext: {
                self.address = $0[0]
                self.urbanVillage = $0[1]
                self.districtName = $0[2]
                self.cityName = $0[3]
                self.provName = $0[4]
            })
            .disposed(by: disposeBag)
        
        viewModel.loading
            .bind(to: loadingView.rx.isAnimating)
            .disposed(by: disposeBag)
        
        viewModel.loading
            .map { item in
                !item
            }
            .bind(to: loadingView.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.loading.onNext(false)
        
        viewModel.user
            .subscribe(onNext: { user in
                self.changeToProfileVC()
            })
            .disposed(by: disposeBag)
        
        viewModel.error
            .subscribe(onNext: { error in
                let alert = UIAlertController(title: error, message: "Mohon gunakan email yang belum pernah didaftarkan", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Oke", style: .default, handler: { _ in
                    self.emailTextField.text = ""
                    self.emailTextField.becomeFirstResponder()
                }))
                
                self.present(alert, animated: true, completion: nil)
            })
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
        viewModel.register(name: name, email: email, whatsappNumber: whatsappNumber, password: password, alamat: address, provinsi: provName, kota: cityName, kelurahan: urbanVillage, kecamatan: districtName, longtitude: 0.0, latitude: 0.0)
        
    }
    
    private func setupAlert(errorValidationType: RegisterErrorValidationType) -> UIAlertController {
        let alert = UIAlertController(title: errorValidationType.getTitle(), message: errorValidationType.getMessage(), preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Baik", style: .default, handler: { action in
            switch errorValidationType {
            case .email: self.emailTextField.becomeFirstResponder()
            case .whatsappNumber: self.whatsappNumberTextField.becomeFirstResponder()
            case .password: self.passwordTextField.becomeFirstResponder()
            case .passwordConfirmation: self.confirmPasswordTextField.becomeFirstResponder()
            case .address: self.goToAlamatViewController()
            }
        }))
        
        return alert
    }
}

// MARK: - UITextFieldDelegate

extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == whatsappNumberTextField {
            if let whatsappNumber = whatsappNumberTextField.text?.trimmingCharacters(in: .whitespaces) {
                let fixedWhatsappNumber = whatsappNumber.filter {
                    !$0.isWhitespace
                }
                
                whatsappNumberTextField.text = fixedWhatsappNumber
                whatsappNumberTextField.sendActions(for: .allEditingEvents)
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
    
    private func changeToProfileVC() {
        let profileVC = UINavigationController(rootViewController: ProfileViewController())
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle.fill"), tag: 1)

        self.tabBarController?.viewControllers?[1] = profileVC
    }
}

// MARK: - RegisterErrorValidationType

extension RegisterViewController {
    enum RegisterErrorValidationType {
        case email
        case whatsappNumber
        case password
        case passwordConfirmation
        case address
        
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
            case .address:
                return "Alamat belum terisi"
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
            case .address:
                return "Mohon isi alamat benar"
            }
        }
    }
}
