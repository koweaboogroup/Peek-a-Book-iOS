//
//  ProfileViewController.swift
//  Peek-a-Book
//
//  Created by Yossan Sandi Rahmadi on 26/07/21.
//

import UIKit

class ProfileViewController: UIViewController {
    // MARK: -Deklarasi IBOutlet
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
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
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    
    
    
    
    
    
    
    // MARK: -Deklarasi Action Button
    @IBAction func ButtonEditProfileTouched(_ sender: UIButton) {
        
        let vc = EditProfileViewController(
            nibName: "\(EditProfileViewController.self)",
                bundle: nil)
        vc.hidesBottomBarWhenPushed = true
             navigationController?.pushViewController(vc,
                animated: true)
        
    }
    
    @IBAction func tapRiwayatPenyewaan(_ sender: UITapGestureRecognizer) {
        
        print("Riwayat Penyewaan Buku")
        
        
    }
    
    @IBAction func tapMulaiSewakanBuku(_ sender: UITapGestureRecognizer) {
        
        print("Mulai Sewakan Buku")
        
    }
    
    @IBAction func tapSyaratDanKetentuan(_ sender: UITapGestureRecognizer) {
        
        print("Syarat Dan Ketentuan bukunya gimana?")
    }
    
    @IBAction func tapKeluar(_ sender: UITapGestureRecognizer) {
        print("Babay")
    }
    
    
    
    
    
    
    
    
    
    
    
}
