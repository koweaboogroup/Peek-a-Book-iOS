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
    @IBOutlet weak var renterNameLabel: UILabel!
    @IBOutlet weak var renterStreetLabel: UILabel!
    @IBOutlet weak var renterSubDistrictLabel: UILabel!
    @IBOutlet weak var renterDistrictLabel: UILabel!
    @IBOutlet weak var renterCountryLabel: UILabel!
    @IBOutlet weak var renterPhoneLabel: UILabel!
    
    // MARK: - Detail Buku
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var detailBukuTableView: UITableView!
    @IBOutlet var detailBukuTableHeight: NSLayoutConstraint!
    
    // MARK: - Detail Sewa
    @IBOutlet weak var rentDurationLabel: UILabel!
    @IBOutlet weak var rentDeliveryMethodLabel: UILabel!
    @IBOutlet weak var rentDeliveryFeeLabel: UILabel!
    @IBOutlet weak var rentFeeLabel: UILabel!
    @IBOutlet weak var rentDeadlineDateLabel: UILabel!
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        self.detailBukuTableHeight?.constant = self.detailBukuTableView.contentSize.height - 4
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewWillLayoutSubviews()
    }
    
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
        setView()
        setRx()
    }
    
    private func setNavigationBar(){
        self.navigationItem.title = "Detail Order"
        
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "DM Serif Text", size: 19)!]
        
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "DM Serif Text", size: 19.0)!], for: .normal)
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
    private func setView(){
        detailBukuTableView.layer.applyShadow(color: .black, alpha: 0.1, x: 0, y: 2, blur: 5, spread: 0)
    }
    
    
    private func setRx(){
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
            order.rent?.user?.username
        }.bind(to: renterNameLabel.rx.text)
        .disposed(by: disposeBag)
        
        viewModel.order.asObserver().map { order in
            order.rent?.alamat
        }.bind(to: renterStreetLabel.rx.text)
        .disposed(by: disposeBag)
        
        viewModel.order.asObserver().map { order in
            order.rent?.user?.phoneNumber
        }.bind(to: renterPhoneLabel.rx.text)
        .disposed(by: disposeBag)
        
        viewModel.order.asObserver().map { order in
            "\(order.rent?.periodOfTime ?? -1)"
        }.bind(to: rentDurationLabel.rx.text)
        .disposed(by: disposeBag)
        
        viewModel.order.asObserver().map { order in
            order.rent?.shippingMethods
        }.bind(to: rentDeliveryMethodLabel.rx.text)
        .disposed(by: disposeBag)
        
        viewModel.order.asObserver().map { order in
            order.rent?.user?.username
        }.bind(to: profileNameLabel.rx.text)
        .disposed(by: disposeBag)

        detailBukuTableView.register(UINib(nibName: XIBConstant.ItemKeranjangTableViewCell, bundle: nil), forCellReuseIdentifier: String(describing: ItemKeranjangTableViewCell.self))
        
        viewModel.order.asObservable().map{ order in
            order.lenderBooks ?? []
        }.bind(to: detailBukuTableView.rx.items(cellIdentifier: "ItemKeranjangTableViewCell", cellType: ItemKeranjangTableViewCell.self)){(row, lenderBook, cell) in
            let url = URL(string: Constant.Network.baseUrl + (lenderBook.images?[0].url ?? ""))
            cell.bookImage.kf.setImage(with: url)
            cell.bookTitle.text = lenderBook.book?.title
            cell.bookWriter.text = lenderBook.book?.author
            
        }.disposed(by: disposeBag)
    }
    
    @IBAction func backToHomePageButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func buttonLihatAlamatPressed(_ sender: UIButton) {
    }

}
