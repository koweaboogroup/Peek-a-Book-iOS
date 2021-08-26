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
    @IBOutlet weak var fieldStoreAddress: CustomTextField!
    
    private let viewModel = ProfileLenderViewModel()
    private let disposeBag = DisposeBag()
    
    private var imagePicker: ImagePicker?
    
    var lenderId: Int?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchProfileLender()
        setupObject()
        setupView()
        setupRx()
    }
    
    private func fetchProfileLender(){
        viewModel.getLenderProfile(lenderId: lenderId ?? -1)
    }
    
    private func setupObject(){
        imagePicker = ImagePicker(presentationController: self, delegate: self)
    }
    
    private func setupView(){
        containerView.layer.applyShadow(color: .black, alpha: 0.5, x: 0, y: 2, blur: 4, spread: 0)
        containerView.cornerRadius(20)

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(doneEditing))
        
        fieldStoreName.setTitleLabel("Nama Toko")
        fieldStoreBio.setTitleLabel("Bio")
        fieldStoreAddress.setTitleLabel("Detail Alamat")
        
        fieldStoreName.setPlaceholderField("Nama Toko")
        fieldStoreBio.setPlaceholderField("Keterangan Toko")
        fieldStoreAddress.showChevron(isShow: true)
        
        circleStoreImageView.setBackgroundColor(color: #colorLiteral(red: 0.9058823529, green: 0.9568627451, blue: 1, alpha: 1))
        circleStoreImageView.setPlaceHolderImage(image: #imageLiteral(resourceName: "store"))
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
            self.fieldStoreAddress.fieldName.text = response.alamat
            if let image = response.images {
                if !image.isEmpty {
                    self.circleStoreImageView.setImage(fromUrl: Constant.Network.baseUrl + (image[0].url ?? ""))
                }
            }
        }).disposed(by: disposeBag)
        
    }
    
    @IBAction func editProfileLender(_ sender: UIButton) {
        imagePicker?.present(from: sender)
    }
    
    @objc func doneEditing() {
        viewModel.editLenderProfile(lenderId: lenderId ?? -1, name: fieldStoreName.text, bio: fieldStoreBio.text, user: nil, alamat: nil, provinsi: nil, kota: nil, kelurahan: nil, kecamatan: nil, longtitude: nil, latitude: nil) {
            self.navigationController?.popViewController(animated: true)
        }
    }
}

extension EditProfileLenderViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        if let image = image {
            self.circleStoreImageView.setImage(image: image)
        }
    }
}
