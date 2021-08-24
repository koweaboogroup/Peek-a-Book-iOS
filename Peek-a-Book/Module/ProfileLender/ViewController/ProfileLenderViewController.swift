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

class ProfileLenderViewController: UIViewController {

    @IBOutlet weak var circleLenderImageView: CircleImageView!
    @IBOutlet weak var lenderNameLabel: UILabel!
    @IBOutlet weak var lenderBioLabel: UILabel!
    @IBOutlet weak var lenderLocationLabel: UILabel!
    @IBOutlet weak var BooksCollectionView: UICollectionView!
    
    private let viewModel = ProfileLenderViewModel()
    private let disposeBag = DisposeBag()
    
    private var lenderId: Int = 0
    
    func setLenderId(id: Int) {
        self.lenderId = id
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getLenderProfile(lenderId: lenderId)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRx()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit Profile", style: .plain, target: self, action: #selector(editTapped))
    }
    
    private func setupRx() {
        
        //MARK: - Setup View Detail Toko
        viewModel.lenderProfile.subscribe (onNext: { response in
            if let image = response.images {
                if !image.isEmpty{
                    self.circleLenderImageView.setImage(fromUrl: Constant.Network.baseUrl + (image[0].url ?? ""))
                }
            }
        }).disposed(by: disposeBag)
        
        viewModel.lenderProfile.asObservable().map { response in
            response.name
        }.bind(to: lenderNameLabel.rx.text)
        .disposed(by: disposeBag)
        
        viewModel.lenderProfile.asObservable().map { response in
            response.bio ?? ""
        }.bind(to: lenderBioLabel.rx.text)
        .disposed(by: disposeBag)
        
        //MARK: Ini mapping lokasinya mau pake Kota aja ya?
        viewModel.lenderProfile.asObservable().map { response in
            response.kota
        }.bind(to: lenderLocationLabel.rx.text)
        .disposed(by: disposeBag)
    }
    
    @objc func editTapped(){
        let vc = ModuleBuilder.shared.goToEditProfileLenderViewController()
        vc.lenderId = self.lenderId
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func semuaGenrePressed(_ sender: UIButton) {
        print("Sort Disini")
    }
    
    @IBAction func kelolaPenyewaanGetTapped(_ sender: UITapGestureRecognizer) {
        let vc = ModuleBuilder.shared.goToTransactionViewController()
        vc.hidesBottomBarWhenPushed = true
        vc.setLenderID(id: 6)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
