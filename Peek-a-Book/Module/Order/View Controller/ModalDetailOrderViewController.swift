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
        jalanPemberiSewaLabel.text = order?.alamat
        kelurahanPemberiSewaLabel.text = order?.kelurahan
        kecamatanPemberiSewaLabel.text = order?.kecamatan
        negaraPemberiSewaLabel.text = order?.provinsi
    }


}
