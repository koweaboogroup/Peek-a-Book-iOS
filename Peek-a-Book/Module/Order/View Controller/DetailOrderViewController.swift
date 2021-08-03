//
//  DetailOrderViewController.swift
//  Peek-a-Book
//
//  Created by Gede Wicaksana on 02/08/21.
//

import UIKit

class DetailOrderViewController: UIViewController {

    // MARK: - Header View
    @IBOutlet weak var informationStatusLabel: UILabel!
    @IBOutlet weak var nomorOrderPenyewaanLabel: UILabel!
    
    // MARK: - Detail Penyewa
    @IBOutlet weak var namaPenyewaLabel: UILabel!
    @IBOutlet weak var jalanPenyewaLabel: UILabel!
    @IBOutlet weak var kelurahanPenyewaLabel: UILabel!
    @IBOutlet weak var kecamatanPenyewaLabel: UILabel!
    @IBOutlet weak var negaraPenyewaLabel: UILabel!
    @IBOutlet weak var nomorTeleponPenyewaLabel: UILabel!
    
    // MARK: - Detail Buku
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var detailBukuTableView: UITableView!
    
    // MARK: - Detail Sewa
    @IBOutlet weak var durasiSewaLabel: UILabel!
    @IBOutlet weak var metodePengirimanLabel: UILabel!
    @IBOutlet weak var biayaPengirimanLabel: UILabel!
    @IBOutlet weak var totalBiayaLabel: UILabel!
    @IBOutlet weak var tanggalBatasSewaLabel: UILabel!
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func kembaliKeHomepagePressed(_ sender: UIButton) {
        print("To homepage")
        
    }
    

}
