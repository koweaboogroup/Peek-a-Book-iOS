//
//  ProfileTokoViewController.swift
//  Peek-a-Book
//
//  Created by Gede Wicaksana on 05/08/21.
//

import UIKit
import RxSwift
import RxCocoa

class ProfileTokoViewController: UIViewController {

    @IBOutlet weak var profilTokoImage: UIImageView!
    @IBOutlet weak var namaTokoLabel: UILabel!
    @IBOutlet weak var bioTokoLabel: UILabel!
    
    @IBOutlet weak var lokasiTokoLabel: UILabel!
    
    @IBOutlet weak var koleksiBukuCollectionView: UICollectionView!
    
    private let viewModel = ProfileLenderViewModel()
    private let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit Profile", style: .plain, target: self, action: #selector(addTapped))
        
        setupRx()

    }
    
    private func setupRx() {
        
        //MARK: - Setup View Detail Toko
        viewModel.lenderProfile.subscribe (onNext: { response in
            let url = URL(string: Constant.Network.baseUrl + (response.image?[0].url ?? ""))
            self.profilTokoImage.kf.setImage(with: url)
        }).disposed(by: disposeBag)
        
        viewModel.lenderProfile.asObserver().map { response in
            response.name
        }.bind(to: namaTokoLabel.rx.text)
        .disposed(by: disposeBag)
        
        viewModel.lenderProfile.asObserver().map { response in
            response.bio
        }.bind(to: bioTokoLabel.rx.text)
        .disposed(by: disposeBag)
        
        //MARK: Ini mapping lokasinya mau pake Kota aja ya?
        viewModel.lenderProfile.asObserver().map { response in
            response.kota
        }.bind(to: lokasiTokoLabel.rx.text)
        .disposed(by: disposeBag)
        
        //MARK: - Setup View Katalog Toko
        
        
    }
    
    
    
    
    @objc func addTapped(){
         print("clicked")
    }
    


    @IBAction func semuaGenrePressed(_ sender: UIButton) {
        print("Sort Disini")
    }
    
    @IBAction func kelolaPenyewaanGetTapped(_ sender: UITapGestureRecognizer) {
        print("Kelola Penyewaan")
    }
}
