//
//  ProfileTokoViewController.swift
//  Peek-a-Book
//
//  Created by Gede Wicaksana on 05/08/21.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher
import RxKingfisher

class ProfileTokoViewController: UIViewController {

    @IBOutlet weak var profilTokoImage: CircleImageView!
    @IBOutlet weak var namaTokoLabel: UILabel!
    @IBOutlet weak var bioTokoLabel: UILabel!
    
    @IBOutlet weak var lokasiTokoLabel: UILabel!
    
    @IBOutlet weak var koleksiBukuCollectionView: UICollectionView!
    
    private let viewModel = ProfileLenderViewModel()
    private let disposeBag = DisposeBag()
    
    private var lenderId: Int = 0
    
    func setLenderId(id: Int) {
        self.lenderId = id
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit Profile", style: .plain, target: self, action: #selector(editTapped))
        
        viewModel.getLenderProfile(lenderId: lenderId)
        setupRx()
    }
    
    private func setupRx() {
        
        //MARK: - Setup View Detail Toko
        viewModel.lenderProfile.subscribe (onNext: { response in
            self.profilTokoImage.setImage(fromUrl: Constant.Network.baseUrl + (response.images?[0].url ?? ""))
        }).disposed(by: disposeBag)
        
        viewModel.lenderProfile.asObserver().map { response in
            response.name
        }.bind(to: namaTokoLabel.rx.text)
        .disposed(by: disposeBag)
        
        viewModel.lenderProfile.asObserver().map { response in
            response.bio ?? ""
        }.bind(to: bioTokoLabel.rx.text)
        .disposed(by: disposeBag)
        
        //MARK: Ini mapping lokasinya mau pake Kota aja ya?
        viewModel.lenderProfile.asObserver().map { response in
            response.kota
        }.bind(to: lokasiTokoLabel.rx.text)
        .disposed(by: disposeBag)
    }
    
    
    
    
    @objc func editTapped(){
        let vc = ModuleBuilder.shared.goToEditProfileLenderViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    


    @IBAction func semuaGenrePressed(_ sender: UIButton) {
        print("Sort Disini")
    }
    
    @IBAction func kelolaPenyewaanGetTapped(_ sender: UITapGestureRecognizer) {
        print("Kelola Penyewaan")
    }
}
