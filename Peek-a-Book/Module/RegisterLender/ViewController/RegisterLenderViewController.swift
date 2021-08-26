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
    
    //MARK: - IBOutlet
    @IBOutlet weak var circleProfileImageView: CircleImageView!
    @IBOutlet weak var buttonRegisterLender: UIButton!
    @IBOutlet weak var registerContentView: RegisterContentView!
        
    //MARK: - Variable
    private let viewModel = RegisterLenderViewModel()
    private let addressViewModel = AddressViewModel()
    private let disposeBag = DisposeBag()
    
    private var address: String = ""
    private var provName = ""
    private var cityName = ""
    private var urbanVillage = ""
    private var districtName = ""
    private let longitude:Float = 0.0
    private let latitude:Float = 0.0
    
    private var imagePicker: ImagePicker?
    
    //MARK: - IBActions
    @IBAction func buttonRegisterLenderPressed(_ sender: Any) {
        processRegisterLender()
    }
    
    @IBAction func choosePhotoDidTapped(_ sender: UIButton) {
        imagePicker?.present(from: sender)
    }

    //MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupRx()
        setupListener()
    }
    
    private func setupRx() {
        addressViewModel.getAllAddressFieldsObservable()
            .subscribe(onNext: {
                self.address = $0[0]
                self.urbanVillage = $0[1]
                self.districtName = $0[2]
                self.cityName = $0[3]
                self.provName = $0[4]
            })
            .disposed(by: disposeBag)

        registerContentView.storeNameTextField.rx.text.map({
            return $0 ?? ""
        }).bind(to: viewModel.storeName)
        .disposed(by: disposeBag)
                
        addressViewModel.address
            .bind(to: registerContentView.detailAddressLabel.rx.text)
            .disposed(by: disposeBag)
        
        addressViewModel.address
            .bind(to: viewModel.addressName)
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
    
    private func setupListener(){
        imagePicker = ImagePicker(presentationController: self, delegate: self)
        
        viewModel.isAllTextFieldFilled()
            .bind(to: buttonRegisterLender.rx.isEnabled)
            .disposed(by: disposeBag)
        
        viewModel.isAllTextFieldFilled().map {
            return $0 ? 1 : 0.5
        }.bind(to: buttonRegisterLender.rx.alpha)
        .disposed(by: disposeBag)

        viewModel.detailAddressPressed.asObserver()
            .subscribe(onNext: { pressed in
                if pressed {
                    let vc = ModuleBuilder.shared.goToAlamatViewController()
                    vc.initViewModel(viewModel: self.addressViewModel)
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.user.subscribe(onNext: { item in
            self.changeToProfileLender(item.id ?? 0)
        }).disposed(by: disposeBag)
    }
    
    private func processRegisterLender() {
        let name = registerContentView.storeNameTextField.text ?? ""
        let bio = registerContentView.storeBioTextField.text ?? ""
        let user = String(DataManager.shared.getUserIdByJwt())
        
        viewModel.registerLender(name: name, bio: bio, user: user, alamat: address, provinsi: provName, kota: cityName, kelurahan: urbanVillage, kecamatan: districtName, longtitude: longitude, latitude: latitude)
    }
    
    private func changeToProfileLender(_ id: Int){
        self.navigationController?.popViewController(animated: true)
        let vc = ModuleBuilder.shared.goToProfileLenderViewController()
        vc.hidesBottomBarWhenPushed = true
        vc.setLenderId(id: id)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension RegisterLenderViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        if let image = image {
            self.circleProfileImageView.setImage(image: image)
        }
    }
}
