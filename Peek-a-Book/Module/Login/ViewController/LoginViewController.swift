//
//  LoginViewController.swift
//  Peek-a-Book
//
//  Created by Yossan Sandi Rahmadi on 29/07/21.
//

import UIKit
import RxSwift

class LoginViewController: UIViewController {
    
    // MARK: - Variable (Outlet)
    
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBOutlet weak var loginViewContent: LoginContentView!
    @IBOutlet weak var loginViewContentBottomConstraint: NSLayoutConstraint!
    
    // MARK: - Variable
    
    let viewModel = LoginViewModel()
    let disposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.backButtonTitle = ""
        
        showNavigation(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRx()

        loginViewContent.initViewModel(viewModel)
        
        self.hideKeyboardWhenTappedAround()
        
        self.setupKeyboardListener(selector: #selector(handleKeyboardNotification))
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        showNavigation(false)
    }
    
    // MARK: - Private Function
    
    private func setupRx() {
        viewModel.loading
            .bind(to: loadingView.rx.isAnimating)
            .disposed(by: disposeBag)
        
        viewModel.loading.map { item in
            !item
        }.bind(to: loadingView.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.loading.onNext(false)


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

            alert.addAction(UIAlertAction(title: "Baik", style: .default, handler: { action in
                self.loginViewContent.identifierTextField.becomeFirstResponder()
            }))

            self.present(alert, animated: true, completion: nil)
        }).disposed(by: disposeBag)

        viewModel.user.subscribe(onNext: { user in
            self.changeToProfileVC()
        }).disposed(by: disposeBag)
        
        viewModel.buttonRegisterPressed.subscribe (onNext: { pressed in
            if pressed {
                self.changeToRegisterVC()
            }
        }).disposed(by: disposeBag)

    }
    
    private func changeToProfileVC() {
        let profileVC = UINavigationController(rootViewController: ProfileViewController())
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle.fill"), tag: 1)

        self.tabBarController?.viewControllers?[1] = profileVC
    }
    
    private func changeToRegisterVC(){
        let vc = ModuleBuilder.shared.goToRegisterViewController()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Private Function (Selector)
    
    @objc private func handleKeyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let keyboardFrameValue = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)
            let keyboardFrame = keyboardFrameValue?.cgRectValue

            let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification

            loginViewContentBottomConstraint.constant = isKeyboardShowing ? keyboardFrame!.height - keyboardFrame!.height * 0.3 : 4
            
            self.view.layoutIfNeeded()
        }
    }

}
