//
//  EditProfileViewController.swift
//  Peek-a-Book
//
//  Created by Gede Wicaksana on 29/07/21.
//

import UIKit
import RxSwift

class EditProfileViewController: UIViewController {
    
    @IBOutlet weak var imageProfile: CircleImageView!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var whatsappNumberTextField: UITextField!
    
    private var profileViewModel = ProfileViewModel()
    private var disposedBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setNavigationBar()
        fetchProfile()
        setupRx()
    }
    
    private func setNavigationBar(){
        self.navigationItem.title = "Edit Profil"
        
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "DM Serif Text", size: 19)!]
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Simpan", style: .done, target: self, action: #selector(saveTapped))
        
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
        imageProfile.setPlaceHolderImage(image: UIImage(systemName: "person.fill")!)
        imageProfile.setBackgroundColor(color: #colorLiteral(red: 0.9058823529, green: 0.9568627451, blue: 1, alpha: 1))
        profileViewModel.user.asObserver()
            .map{ user in
                user.username
            }
            .bind(to: fullNameTextField.rx.text)
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
            .bind(to: whatsappNumberTextField.rx.text)
            .disposed(by: disposedBag)
        
    }
    
    @objc private func saveTapped(_ sender: UINavigationItem){
    }
    
    @IBAction func detailAddressGetTapped(_ sender: UITapGestureRecognizer) {
    }
    
}
