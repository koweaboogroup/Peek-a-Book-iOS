//
//  AlamatSettingViewController.swift
//  Peek-a-Book
//
//  Created by Gede Wicaksana on 03/08/21.
//

import UIKit
import RxCocoa
import RxSwift

class AddressSettingViewController: UIViewController {
    
    @IBOutlet weak var kecamatanTextField: UITextField!
    @IBOutlet weak var kelurahanTextField: UITextField!
    @IBOutlet weak var kotaTextField: UITextField!
    @IBOutlet weak var provinsiTextField: UITextField!
    @IBOutlet weak var jalanTextField: UITextField!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var checkBoxView: UIStackView!
    
    private var mapsViewModel : MapsViewModel = MapsViewModel()
    private var addressViewModel: AddressViewModel?
    private var disposeBag = DisposeBag()
    
    private var isClicked = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupView()
    }
    
    func initViewModel(viewModel: AddressViewModel) {
        addressViewModel = viewModel
    }
    
    private func setupNavigation(){
        self.title = "Detail Alamat"
        self.navigationItem.backButtonTitle = ""
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(doneEditing))

    }
    
    @objc func doneEditing() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setupView(){
        if DataManager.shared.isLoggedIn() {
            checkBoxView.isHidden = false
        }else{
            checkBoxView.isHidden = true
        }
        
        mapsViewModel.districtName
            .asObserver()
            .bind(to: kecamatanTextField.rx.text)
            .disposed(by: disposeBag)
        
        mapsViewModel.cityName
            .asObserver()
            .bind(to: kotaTextField.rx.text)
            .disposed(by: disposeBag)
        
        mapsViewModel.provName
            .asObserver()
            .bind(to: provinsiTextField.rx.text)
            .disposed(by: disposeBag)
        
        mapsViewModel.streetName
            .asObserver()
            .bind(to: jalanTextField.rx.text)
            .disposed(by: disposeBag)
        
        addressViewModel?.address.onNext(jalanTextField.text ?? "")
        addressViewModel?.cityName.onNext(kotaTextField.text ?? "")
        addressViewModel?.districtName.onNext(kecamatanTextField.text ?? "")
        addressViewModel?.provName.onNext(provinsiTextField.text ?? "")
        
        addressViewModel?.checkBoxClicked.subscribe(onNext: { isClicked in
            if isClicked {
                self.checkButton.imageView?.image = UIImage(named: "checkmark.square.fill")
            }else {
                self.checkButton.imageView?.image = UIImage(named: "checkmark.square")
            }
        }).disposed(by: disposeBag)
    }
    
    @IBAction func mapsBtnPressed(_ sender: Any) {
        let vc = ModuleBuilder.shared.goToMapsViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.initViewModel(mapsViewModel)
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func checkButtonPressed(_ sender: UIButton) {
        isClicked = !isClicked
        print(isClicked)
        if isClicked {
            self.checkButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        }else {
            self.checkButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        }
    }
    
    func insertAllAlamat(){
        let user = DataManager.shared.getUser()
        kecamatanTextField.text = user?.kecamatan
        kelurahanTextField.text = user?.kelurahan
        kotaTextField.text = user?.kota
        provinsiTextField.text = user?.provinsi
        jalanTextField.text = user?.alamat
    }
    
    func removeAllAlamat(){
        kecamatanTextField.text = ""
        kelurahanTextField.text = ""
        kotaTextField.text = ""
        provinsiTextField.text = ""
        jalanTextField.text = ""
    }
}
