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

    @IBOutlet weak var circleStoreImageView: CircleImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var fieldStoreName: CustomTextField!
    @IBOutlet weak var fieldStoreBio: CustomTextField!
    
    private let viewModel = ProfileLenderViewModel()
    private let disposeBag = DisposeBag()
    
    var lenderId: Int?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
        viewModel.getLenderProfile(lenderId: lenderId ?? -1)
        setupView()
        setupRx()
    }
    
    private func setupRx() {
        
        fieldStoreName.fieldName.rx.text.map {
            $0 ?? ""
        }.bind(to: viewModel.storeName)
        .disposed(by: disposeBag)
        
        viewModel.isStoreNameFilled()
            .bind(to: navigationItem.rightBarButtonItem!.rx.isEnabled)
            .disposed(by: disposeBag)
        
        viewModel.isStoreNameFilled().map {
            $0 ? Constant.Color.primary1 : .lightGray
        }.bind(to: navigationItem.rightBarButtonItem!.rx.tintColor)
        .disposed(by: disposeBag)
        
        viewModel.lenderProfile.asObservable().subscribe(onNext: { response in
            self.fieldStoreName.fieldName.text = response.name
            self.fieldStoreName.fieldName.sendActions(for: .allEditingEvents)
            self.fieldStoreBio.fieldName.text = response.bio
            self.fieldStoreBio.fieldName.sendActions(for: .allEditingEvents)
        }).disposed(by: disposeBag)
        
    }
    
    private func setupView(){
        containerView.cornerRadius(10)
        containerView.borderColor = #colorLiteral(red: 0.7450238466, green: 0.7451503873, blue: 0.7536143064, alpha: 1)
        containerView.borderWidth = 1
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(doneEditing))
        
        fieldStoreName.setTitleLabel("Nama Toko")
        fieldStoreBio.setTitleLabel("Bio")
        
        fieldStoreName.setPlaceholderField("Nama Toko")
        fieldStoreBio.setPlaceholderField("Keterangan Toko")
    }
    
    @objc func doneEditing() {
        
        viewModel.editLenderProfile(lenderId: lenderId ?? -1, name: fieldStoreName.text, bio: fieldStoreBio.text, user: nil, alamat: nil, provinsi: nil, kota: nil, kelurahan: nil, kecamatan: nil, longtitude: nil, latitude: nil) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}

