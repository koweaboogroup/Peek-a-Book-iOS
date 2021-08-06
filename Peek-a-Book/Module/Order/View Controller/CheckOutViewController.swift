//
//  CheckOutViewController.swift
//  Peek-a-Book
//
//  Created by Gede Wicaksana on 04/08/21.
//

import UIKit

class CheckOutViewController: UIViewController {

    //MARK: -Header
    @IBOutlet weak var lenderImageView: UIImageView!
    @IBOutlet weak var lenderNameLabel: UILabel!
    @IBOutlet weak var detailBukuTableView: UITableView!
    
    
    //MARK: -Durasi Penyewaan
    @IBOutlet weak var durasiPenyewaanLabel: UILabel!
    @IBOutlet weak var hargaPenyewaanLabel: UILabel!
    
    //MARK: -Detail Pengiriman
    @IBOutlet weak var detailAlamatLabel: UILabel!
    @IBOutlet weak var metodePengirimanLabel: UILabel!
    
    //MARK: -Total Biaya Sewa
    @IBOutlet weak var biayaSewaBukuLabel: UILabel!
    @IBOutlet weak var biayaOngkirLabel: NSLayoutConstraint!
    @IBOutlet weak var estimasiTotalLabel: UILabel!
    
    //MARK: -Button
    @IBOutlet weak var sewaSekarangButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        
    }


    @IBAction func durasiPenyewaanGetTapped(_ sender: UITapGestureRecognizer) {
        print("picker")
    }
    
    @IBAction func detailAlamatGetTapped(_ sender: UITapGestureRecognizer) {
        print("Halaman Alamat")
    }
    
    @IBAction func metodePengirimanGetTapped(_ sender: UITapGestureRecognizer) {
        print("Picker")
    }
    
    @IBAction func sewaSekarangButtonPressed(_ sender: UIButton) {
        print("cabut")
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func setNavigationBar(){
        self.navigationItem.title = "Keranjang"
        
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "DM Serif Text", size: 19)!]
        
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "DM Serif Text", size: 19.0)!], for: .normal)
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }

}
