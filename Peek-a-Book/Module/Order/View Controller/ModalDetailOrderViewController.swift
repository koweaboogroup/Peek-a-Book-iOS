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
    
    private var orderId: Int?
    private let viewModel = DetailOrderViewModel()
    private let disposeBag = DisposeBag()







    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getDetailOrder(orderId: orderId ?? -1)
        //Header

        viewModel.order.asObserver().map { order in
            "\(String(describing: order.name))"
        }.bind(to: namaPemberiSewaLabel.rx.text)
        .disposed(by: disposeBag)

        viewModel.order.asObserver().map { order in
            "\(String(describing: order.alamat))"
        }.bind(to: jalanPemberiSewaLabel.rx.text)
        .disposed(by: disposeBag)

        viewModel.order.asObserver().map { order in
            "\(String(describing: order.kelurahan))"
        }.bind(to: kelurahanPemberiSewaLabel.rx.text)
        .disposed(by: disposeBag)

        viewModel.order.asObserver().map { order in
            "\(String(describing: order.kecamatan))"
        }.bind(to: kecamatanPemberiSewaLabel.rx.text)
        .disposed(by: disposeBag)

        viewModel.order.asObserver().map { order in
            "\(String(describing: order.kota))"
        }.bind(to: negaraPemberiSewaLabel.rx.text)
        .disposed(by: disposeBag)

        viewModel.order.asObserver().map { order in
            "\((order.lenderBooks![0].lender?.user)!)"
        }.bind(to: namaPemberiSewaLabel.rx.text)
        .disposed(by: disposeBag)
    }


}
