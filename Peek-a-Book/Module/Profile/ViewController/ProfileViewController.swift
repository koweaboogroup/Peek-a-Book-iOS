//
//  ProfileViewController.swift
//  Peek-a-Book
//
//  Created by Yossan Sandi Rahmadi on 26/07/21.
//

import UIKit
import RxSwift
import RxCocoa

class ProfileViewController: UIViewController {
    // MARK: -Deklarasi IBOutlet
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    
    private var disposeBag = DisposeBag()
    
    private var userObj = User()
    
    private var profileViewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        fetchProfile()
        setupView()
    }
    
    func setNavigationBar(){
        self.navigationItem.title = "Profil Saya"
        
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "DM Serif Text", size: 19)!]
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "bell.fill"), style: .done, target: self, action: #selector(addTapped))
        
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "DM Serif Text", size: 19.0)!], for: .normal)
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
    @objc func addTapped(_ sender: UINavigationItem){
        print("to notification")
    }
    
    private func fetchProfile(){
        profileViewModel.fetchProfile()
    }
    
    private func setupView(){
        profileViewModel.user.subscribe(onNext: { user in
            self.userObj = user
        }).disposed(by: disposeBag)
        profileViewModel.user
            .asObserver()
            .map { user in
                user.username
            }
            .bind(to: profileNameLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    // MARK: -Deklarasi Action Button
    @IBAction func ButtonEditProfileTouched(_ sender: UIButton) {
        
        let vc = ModuleBuilder.shared.goToEditProfileViewController()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func tapRiwayatPenyewaan(_ sender: UITapGestureRecognizer) {
        
    }
    
    @IBAction func tapMulaiSewakanBuku(_ sender: UITapGestureRecognizer) {
        if userObj.lender != nil {
            let vc = ModuleBuilder.shared.goToProfileLenderViewController()
            vc.setLenderId(id: userObj.lender?.id ?? 0)
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = ModuleBuilder.shared.goToRegisterLenderViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func tapSyaratDanKetentuan(_ sender: UITapGestureRecognizer) {
        
        print("Syarat Dan Ketentuan bukunya gimana?")
    }
    
    @IBAction func tapKeluar(_ sender: UITapGestureRecognizer) {
        profileViewModel.logout()
        let vc = ModuleBuilder.shared.goToLoginViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
