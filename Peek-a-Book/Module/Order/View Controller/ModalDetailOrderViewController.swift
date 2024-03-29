//
//  ModalDetailOrderViewController.swift
//  Peek-a-Book
//
//  Created by Gede Wicaksana on 19/08/21.
//

import UIKit
import RxCocoa
import RxSwift

class ModalDetailOrderViewController: UIViewController {

    @IBOutlet weak var namaPemberiSewaLabel: UILabel!
    @IBOutlet weak var jalanPemberiSewaLabel: UILabel!
    @IBOutlet weak var kelurahanPemberiSewaLabel: UILabel!
    @IBOutlet weak var kecamatanPemberiSewaLabel: UILabel!
    @IBOutlet weak var negaraPemberiSewaLabel: UILabel!
    @IBOutlet weak var nomerTelpPemberiSewaLabel: UILabel!
    
    var order: Rent?
    var nomerTelpPemberiSewa: String = ""
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
     
        setupUI()
    }
    
    private func setupUI() {
        nomerTelpPemberiSewaLabel.text = nomerTelpPemberiSewa
        namaPemberiSewaLabel.text = order?.lenderBooks?[0].lender?.name
        jalanPemberiSewaLabel.text = order?.lenderBooks?[0].lender?.alamat
        kelurahanPemberiSewaLabel.text = order?.lenderBooks?[0].lender?.kelurahan
        kecamatanPemberiSewaLabel.text = order?.lenderBooks?[0].lender?.kecamatan
        negaraPemberiSewaLabel.text = order?.lenderBooks?[0].lender?.provinsi
    }

    @IBAction func dismisButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
