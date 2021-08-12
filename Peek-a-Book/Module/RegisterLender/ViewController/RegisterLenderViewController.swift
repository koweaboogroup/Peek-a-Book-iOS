//
//  RegisterLenderViewController.swift
//  Peek-a-Book
//
//  Created by Arif Rahman on 01/08/21.
//

import UIKit
import RxSwift
import RxCocoa

class RegisterLenderViewController: UIViewController {

    @IBOutlet weak var circleProfileImageView: CircleImageView!
    @IBOutlet weak var buttonRegisterLender: UIButton!
    @IBOutlet weak var registerContentView: RegisterContentView!
    
    private let viewModel = RegisterLenderViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupRx()
    }
    
    private func setupRx() {
        registerContentView.storeNameTextField.rx.text.map({
            return $0 ?? ""
        }).bind(to: viewModel.storeName)
        .disposed(by: disposeBag)
        
        viewModel.isStoreNameFilled()
            .bind(to: buttonRegisterLender.rx.isEnabled)
            .disposed(by: disposeBag)
        
        viewModel.isStoreNameFilled().map {
            return $0 ? 1 : 0.5
        }.bind(to: buttonRegisterLender.rx.alpha)
        .disposed(by: disposeBag)
        
        viewModel.detailAddressPressed.asObserver()
            .subscribe(onNext: { pressed in
                if pressed {
                    let vc = ModuleBuilder.shared.goToAlamatViewController()                    
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            })
            .disposed(by: disposeBag)
    }

    private func setupView(){
        registerContentView.initViewModel(viewModel: viewModel)
        self.navigationItem.title = "Buka Penyewaan"
        self.navigationItem.backButtonTitle = ""

        circleProfileImageView.setPlaceHolderImage(image: #imageLiteral(resourceName: "store"))
        circleProfileImageView.setBackgroundColor(color: #colorLiteral(red: 0.9058823529, green: 0.9568627451, blue: 1, alpha: 1))
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
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
}
