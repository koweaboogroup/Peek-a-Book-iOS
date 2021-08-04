//
//  LoginViewController.swift
//  Peek-a-Book
//
//  Created by Yossan Sandi Rahmadi on 29/07/21.
//

import UIKit
import RxSwift

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginViewContent: LoginContentView!
    
    @IBOutlet weak var loginViewContentBottomConstraint: NSLayoutConstraint!
    
    let viewModel = LoginViewModel()
    let disposeBag = DisposeBag()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    private func setupRx() {
        loginViewContent.identifierTextField.rx.text
            .map {
                return $0 ?? ""
            }
            .bind(to: viewModel.identifier)
            .disposed(by: disposeBag)
        
        loginViewContent.passwordTextField.rx.text
            .map {
                return $0 ?? ""
            }
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)
        
        viewModel.isAllTextFieldsFilled()
            .bind(to: loginViewContent.loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        viewModel.isAllTextFieldsFilled()
            .map {
                return $0 ? 1 : 0.5
            }
            .bind(to: loginViewContent.loginButton.rx.alpha)
            .disposed(by: disposeBag)
        
        
        viewModel.error.subscribe(onNext: { error in
            let alert = UIAlertController(title: "Tidak Berhasil Masuk", message: "Email atau password Anda salah", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Baiklah!", style: .default, handler: { action in
                self.loginViewContent.identifierTextField.becomeFirstResponder()
            }))

            self.present(alert, animated: true, completion: nil)
        }).disposed(by: disposeBag)

        viewModel.user.subscribe(onNext: { user in
            self.changeToProfileVC()
        }).disposed(by: disposeBag)
        
        viewModel.buttonRegisterPressed.subscribe (onNext: { pressed in
            if pressed {
                let vc = ModuleBuilder.shared.goToRegisterViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }).disposed(by: disposeBag)

    }
    
    private func changeToProfileVC() {
        let profileVC = UINavigationController(rootViewController: ProfileViewController())
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle.fill"), tag: 1)

        self.tabBarController?.viewControllers?[1] = profileVC
    }
    
    private func changeToRegisterVC(){
        //TODO TAMBAHKAN METHOD UNTUK BERALIH KE HALAMAN REGISTER
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginViewContent.initViewModel(viewModel)
        
        self.hideKeyboardWhenTappedAround()
        
        self.setupKeyboardListener(selector: #selector(handleKeyboardNotification))
        
        setupRx()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @objc func handleKeyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let keyboardFrameValue = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)
            let keyboardFrame = keyboardFrameValue?.cgRectValue

            let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification

            loginViewContentBottomConstraint.constant = isKeyboardShowing ? keyboardFrame!.height - keyboardFrame!.height * 0.3 : 4
            
            self.view.layoutIfNeeded()
        }
    }

}
