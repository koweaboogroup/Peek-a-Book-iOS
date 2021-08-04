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

    @IBOutlet weak var circleImageView: CircleImageView!
    
    @IBOutlet weak var buttonRegisterLender: UIButton!
    @IBOutlet weak var registerContentView: RegisterContentView!
    
    private let viewModel = RegisterLenderViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupRx()
        // Do any additional setup after loading the view.
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
