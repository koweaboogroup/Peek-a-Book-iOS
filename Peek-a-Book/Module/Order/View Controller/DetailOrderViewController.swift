//
//  DetailOrderViewController.swift
//  Peek-a-Book
//
//  Created by Gede Wicaksana on 02/08/21.
//

import UIKit
import RxSwift
import RxCocoa

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
    
    var orderId: Int?
    private let viewModel = DetailOrderViewModel()
    private let disposeBag = DisposeBag()
    
    init(orderId: Int, nibName: String) {
        super.init(nibName: nibName, bundle: nil)
        self.orderId = orderId
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        
        viewModel.getDetailOrder(orderId: orderId ?? -1)
      
//        nomorOrderPenyewaanLabel.rx.text.map {
//            $0 ?? ""
//        }.bind(to: viewModel.order)
//        .disposed(by: disposeBag)
        
        viewModel.order.asObserver().map { order in
            "\(order.id ?? -1)"
        }.bind(to: nomorOrderPenyewaanLabel.rx.text)
        .disposed(by: disposeBag)
        
        viewModel.order.asObserver().map { order in
            order.rent?.users.username
        }.bind(to: namaPenyewaLabel.rx.text)
        .disposed(by: disposeBag)
        
        viewModel.order.asObserver().map { order in
            order.rent?.alamat
        }.bind(to: jalanPenyewaLabel.rx.text)
        .disposed(by: disposeBag)
        
        viewModel.order.asObserver().map { order in
            order.rent?.users.phoneNumber
        }.bind(to: nomorTeleponPenyewaLabel.rx.text)
        .disposed(by: disposeBag)
        
        viewModel.order.asObserver().map { order in
            "\(order.rent?.periodOfTime ?? -1)"
        }.bind(to: durasiSewaLabel.rx.text)
        .disposed(by: disposeBag)
        
        viewModel.order.asObserver().map { order in
            order.rent?.shippingMethods
        }.bind(to: metodePengirimanLabel.rx.text)
        .disposed(by: disposeBag)
        
        viewModel.order.asObserver().map { order in
            order.rent?.users.username
        }.bind(to: profileNameLabel.rx.text)
        .disposed(by: disposeBag)

        detailBukuTableView.register(UINib(nibName: XIBConstant.ItemKeranjangTableViewCell, bundle: nil), forCellReuseIdentifier: String(describing: ItemKeranjangTableViewCell.self))
        
//        viewModel.order.asObserver().map { order in
//            order.lenderBooks ??
//        }.bind(to: detailBukuTableView.rx.items(cellIdentifier: "ItemKeranjangTableViewCell", cellType: ItemKeranjangTableViewCell.self)) {  (row,book,cell) in
//                cell.response = book
//            }.disposed(by: disposeBag)
        
        
        
 
     

   

        
        
    }
    
    
    
    
    func setNavigationBar(){
        self.navigationItem.title = "Detail Order"
        
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "DM Serif Text", size: 19)!]
        
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "DM Serif Text", size: 19.0)!], for: .normal)
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    


    @IBAction func kembaliKeHomepagePressed(_ sender: UIButton) {
        print("To homepage")
        
    }
    

}
