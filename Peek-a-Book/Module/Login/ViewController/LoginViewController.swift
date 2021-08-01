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
    
    private func setupSubcribe() {
        viewModel.error.subscribe(onNext: { error in
            let alert = UIAlertController(title: "Tidak berhasil login", message: "Coba dinget2 lagi, yok bisa yok", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Baiklah!", style: .default, handler: { action in
                self.loginViewContent.identifierTextField.becomeFirstResponder()
            }))
            
            self.present(alert, animated: true, completion: nil)
        }).disposed(by: disposeBag)
        
        viewModel.user.subscribe(onNext: { user in
            self.changeToProfileVC()
        }).disposed(by: disposeBag)
    }
    
    private func changeToProfileVC() {
        let profileVC = UINavigationController(rootViewController: ProfileViewController())
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle.fill"), tag: 1)

        self.tabBarController?.viewControllers?[1] = profileVC
    }
    
    private func setupKeyboardListener() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginViewContent.initViewModel(viewModel)
        
        self.hideKeyboardWhenTappedAround()
        
        setupKeyboardListener()
        
        setupSubcribe()
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
