//
//  EditProfileLenderViewController.swift
//  Peek-a-Book
//
//  Created by Arif Rahman on 03/08/21.
//

import UIKit
import RxSwift
import RxCocoa

class EditProfileLenderViewController: UIViewController {

    @IBOutlet weak var circleImageView: CircleImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var fieldStoreName: CustomTextField!
    @IBOutlet weak var fieldStoreBio: CustomTextField!
    
    private let viewModel = ProfileLenderViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
        setupRx()
    }
    
    private func setupRx() {
        
        /* GABISA AKSES STRING-NYA SI TEXTFIELD YAALLAH ASTAGFIRULLAH KENAPA CUSTOM TEXTFIELD TYPE-NYA😭😭😭
         
        viewModel.lenderProfile.asObserver().map { response in
            response.name
        }.bind(to: fieldStoreName.rx.fieldName.)
        .disposed(by: disposeBag)
         
        */
         
    }
    
    private func setupView(){
        containerView.cornerRadius(10)
        containerView.borderColor = #colorLiteral(red: 0.7450238466, green: 0.7451503873, blue: 0.7536143064, alpha: 1)
        containerView.borderWidth = 1
        
        fieldStoreName.setTitleLabel("Nama Toko")
        fieldStoreBio.setTitleLabel("Bio")
    }
}
