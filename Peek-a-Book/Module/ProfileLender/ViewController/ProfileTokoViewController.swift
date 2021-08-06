//
//  ProfileTokoViewController.swift
//  Peek-a-Book
//
//  Created by Gede Wicaksana on 05/08/21.
//

import UIKit

class ProfileTokoViewController: UIViewController {

    @IBOutlet weak var profilTokoImage: UIImageView!
    @IBOutlet weak var namaTokoLabel: UILabel!
    @IBOutlet weak var bioTokoLabel: UILabel!
    
    @IBOutlet weak var lokasiTokoLabel: UILabel!
    
    @IBOutlet weak var koleksiBukuCollectionView: UICollectionView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit Profile", style: .plain, target: self, action: #selector(addTapped))

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
