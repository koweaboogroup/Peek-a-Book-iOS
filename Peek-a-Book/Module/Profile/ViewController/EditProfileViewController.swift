//
//  EditProfileViewController.swift
//  Peek-a-Book
//
//  Created by Gede Wicaksana on 29/07/21.
//

import UIKit
import RxSwift

class EditProfileViewController: UIViewController {
    
    @IBOutlet weak var namaLengkapTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var noWhatsappTextField: UITextField!
    
    private var profileViewModel = ProfileViewModel()
    private var disposedBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setNavigationBar()
        fetchProfile()
        setupRx()
    }
    
    func setNavigationBar(){
        self.navigationItem.title = "Edit Profil"
        
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "DM Serif Text", size: 19)!]
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Simpan", style: .done, target: self, action: #selector(addTapped))
        
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "DM Serif Text", size: 19.0)!], for: .normal)
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
    private func fetchProfile(){
        profileViewModel.fetchProfile()
    }
    
    private func setupRx() {
        profileViewModel.user.asObserver()
            .map{ user in
                user.username
            }
            .bind(to: namaLengkapTextField.rx.text)
            .disposed(by: disposedBag)
        
        profileViewModel.user.asObserver()
            .map{ user in
                user.email
            }
            .bind(to: emailTextField.rx.text)
            .disposed(by: disposedBag)
        
        profileViewModel.user.asObserver()
            .map{ user in
                user.phoneNumber
            }
            .bind(to: noWhatsappTextField.rx.text)
            .disposed(by: disposedBag)
        
    }
    
    @objc func addTapped(_ sender: UINavigationItem){
        print("Simpan")
    }
    
    @IBAction func detailAlamatGetTap(_ sender: UITapGestureRecognizer) {
        print("Pindah Ke maps")
    }
    
}
