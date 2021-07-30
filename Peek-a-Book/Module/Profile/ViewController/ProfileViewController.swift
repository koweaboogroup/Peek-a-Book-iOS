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
