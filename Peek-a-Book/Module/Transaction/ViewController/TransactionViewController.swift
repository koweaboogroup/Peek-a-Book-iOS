//
//  TransactionViewController.swift
//  Peek-a-Book
//
//  Created by Arif Rahman on 13/08/21.
//

import UIKit
import RxSwift
import RxCocoa

class TransactionViewController: UIViewController {
    
    enum FlagFromPage {
        case riwayatPenyewaan, kelolaPenyewaan
    }
    
    @IBOutlet weak var transactionTableView: UITableView!
    private let viewModel = RentViewModel()
    private let disposeBag = DisposeBag()

    private var id = 0
    private var lenderId = 0
    private var flagFrom: FlagFromPage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTransaction()
        setupView()
    }
    
    func setUserID(id: Int){
        self.id = id
        flagFrom = .riwayatPenyewaan
    }
    
    func setLenderID(id: Int) {
        self.lenderId = id
        flagFrom = .kelolaPenyewaan
    }
    
    private func fetchTransaction(){
        switch flagFrom {
        case .riwayatPenyewaan:
            viewModel.getListRentAsUser(id: id)
        case .kelolaPenyewaan:
            viewModel.getListRentAsLender(id: lenderId)
        case .none:
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    private func setupView(){
        transactionTableView.register(UINib(nibName: XIBConstant.RentBookItemTableViewCell, bundle: nil), forCellReuseIdentifier: XIBConstant.RentBookItemTableViewCell)

        viewModel.orders.bind(to: transactionTableView.rx.items(cellIdentifier: XIBConstant.RentBookItemTableViewCell, cellType: RentBookItemTableViewCell.self)) {  (row, transaction, cell) in
            cell.response = transaction
            }.disposed(by: disposeBag)
    }
}
