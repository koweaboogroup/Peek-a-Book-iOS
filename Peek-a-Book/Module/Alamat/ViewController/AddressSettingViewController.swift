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
    
    @IBOutlet weak var districtTextField: UITextField!
    @IBOutlet weak var subDistrictTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var provTextField: UITextField!
    @IBOutlet weak var streetTextField: UITextField!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var checkBoxView: UIStackView!
    
    private var mapsViewModel : MapsViewModel = MapsViewModel()
    private var addressViewModel: AddressViewModel?
    private var disposeBag = DisposeBag()
    
    private var isClicked = false
    private var isFilled = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if !isFilled {
            addressViewModel?.address.onNext("")
        }
    }
    
    func initViewModel(viewModel: AddressViewModel) {
        addressViewModel = viewModel
    }
    
    private func setupNavigation() {
        title = "Detail Alamat"
        navigationItem.backButtonTitle = ""
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(doneEditing))
    }
    
    @objc func doneEditing() {
        if isFilled {
            self.navigationController?.popViewController(animated: true)
        } else {
            let alert = UIAlertController(title: "Detail Alamat Belum Lengkap", message: "Mohon mengisi seluruh detail alamat", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Baik", style: .default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    private func setupView(){
        if DataManager.shared.isLoggedIn() {
            checkBoxView.isHidden = false
        }else{
            checkBoxView.isHidden = true
        }
        
        mapsViewModel.streetName
            .subscribe(onNext: {
                self.streetTextField.text = $0
                self.streetTextField.sendActions(for: .allEditingEvents)
            })
            .disposed(by: disposeBag)
        
        mapsViewModel.cityName
            .subscribe(onNext: {
                self.cityTextField.text = $0
                self.cityTextField.sendActions(for: .allEditingEvents)
            })
            .disposed(by: disposeBag)
        
        mapsViewModel.districtName
            .subscribe(onNext: {
                self.districtTextField.text = $0
                self.districtTextField.sendActions(for: .allEditingEvents)
            })
            .disposed(by: disposeBag)
        
        mapsViewModel.provName
            .subscribe(onNext: {
                self.provTextField.text = $0
                self.provTextField.sendActions(for: .allEditingEvents)
            })
            .disposed(by: disposeBag)
        
        subDistrictTextField.rx.text
            .map {
                $0?.trimmingCharacters(in: .whitespaces) ?? ""
            }
            .bind(to: addressViewModel?.urbanVillage ?? PublishSubject<String>())
            .disposed(by: disposeBag)
        
        districtTextField.rx.text
            .map {
                $0?.trimmingCharacters(in: .whitespaces) ?? ""
            }
            .bind(to: addressViewModel?.districtName ?? PublishSubject<String>())
            .disposed(by: disposeBag)
        
        cityTextField.rx.text
            .map {
                $0?.trimmingCharacters(in: .whitespaces) ?? ""
            }
            .bind(to: addressViewModel?.cityName ?? PublishSubject<String>())
            .disposed(by: disposeBag)
        
        provTextField.rx.text
            .map {
                $0?.trimmingCharacters(in: .whitespaces) ?? ""
            }
            .bind(to: addressViewModel?.provName ?? PublishSubject<String>())
            .disposed(by: disposeBag)
        
        streetTextField.rx.text
            .map {
                $0?.trimmingCharacters(in: .whitespaces) ?? ""
            }
            .bind(to: addressViewModel?.address ?? PublishSubject<String>())
            .disposed(by: disposeBag)
        
        addressViewModel?.isAllAddressFieldsFilled()
            .subscribe(onNext: { isAllAddressFieldsFilled in
                self.isFilled = isAllAddressFieldsFilled
            })
            .disposed(by: disposeBag)
        
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
}
