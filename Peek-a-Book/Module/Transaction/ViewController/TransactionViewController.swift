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
    
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBOutlet weak var transactionTableView: UITableView!
    @IBOutlet weak var pickerView: UIView!
    @IBOutlet weak var datePickerView: UIDatePicker!
    @IBOutlet weak var confirmationButton: UIButton!
    @IBOutlet weak var statusPickerView: UIPickerView!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusButton: UIButton!
    
    private let viewModel = RentViewModel()
    private let disposeBag = DisposeBag()
    
    private var id = 0
    private var lenderId = 0
    private var flagFrom: FlagFromPage?
    
    private var selectedId = 0
    private var selectedStatus = 0
        
    private var itemsStatus: Observable<[String]> = Observable.of(["Semua Status", "Menunggu Konfirmasi", "Dalam Proses", "Dalam Pengiriman", "Sedang Berlangsung", "Sedang Dikembalikan", "Selesai", "Tidak Selesai"])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchTransaction()
        updateStatus()
        showDatePicker()
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
        viewModel.loading.asObserver()
            .bind(to: loadingView.rx.isAnimating)
            .disposed(by: disposeBag)
        
        viewModel.loading.asObserver()
            .bind(to: transactionTableView.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.loading.asObserver().map{ item in
            !item
        }.bind(to: loadingView.rx.isHidden)
        .disposed(by: disposeBag)
        
        confirmationButton.cornerRadius(10)
        confirmationButton.layer.applyShadow(color: .black, alpha: 0.5, x: 0, y: 2, blur: 4, spread: 0)
        
        transactionTableView.register(UINib(nibName: XIBConstant.RentBookItemTableViewCell, bundle: nil), forCellReuseIdentifier: XIBConstant.RentBookItemTableViewCell)
        
        switch flagFrom {
        case .riwayatPenyewaan:
            viewModel.ordersForRenter.bind(to: transactionTableView.rx.items(cellIdentifier: XIBConstant.RentBookItemTableViewCell, cellType: RentBookItemTableViewCell.self)) {  (row, transaction, cell) in
                cell.setViewModel(viewModel: self.viewModel)
                cell.setViewController(viewController: self)
                cell.response = transaction
                }.disposed(by: disposeBag)
        case .kelolaPenyewaan:
            viewModel.ordersForLender.bind(to: transactionTableView.rx.items(cellIdentifier: XIBConstant.RentBookItemTableViewCell, cellType: RentBookItemTableViewCell.self)) {  (row, transaction, cell) in
                cell.setViewModel(viewModel: self.viewModel)
                cell.setViewController(viewController: self)
                cell.response = transaction
                }.disposed(by: disposeBag)
        case .none:
            break
        }

        itemsStatus
            .bind(to: statusPickerView.rx.itemTitles) { (row, element) in
                return element
            }
            .disposed(by: disposeBag)
        
        itemsStatus.subscribe(onNext: { items in
            self.viewModel.selectedStatus.subscribe(onNext: { status in
                self.statusButton.setTitle(items[status], for: .normal)
                switch self.flagFrom {
                case .riwayatPenyewaan:
                    self.viewModel.getFilteredRentsForRenter(statusId: status + 1)
                    break
                case .kelolaPenyewaan:
                    self.viewModel.getFilteredRentsForLender(statusId: status + 1)
                    break
                case .none:
                    break
                }
            }).disposed(by: self.disposeBag)
        }).disposed(by: disposeBag)
        
        statusPickerView.rx.itemSelected
            .subscribe(onNext: { (row, _) in
                self.selectedStatus(row)
            })
            .disposed(by: disposeBag)
    }
    
    private func selectedStatus(_ status: Int){
        selectedStatus = status
    }
    
    private func updateStatus(){
        viewModel.selectedId.subscribe(onNext: { id in
            self.selectedId = id
        }).disposed(by: disposeBag)
        
        viewModel.isSuccessChange.subscribe(onNext: { isChange in
            if !isChange {
                self.fetchTransaction()
            }
        }).disposed(by: disposeBag)
    }
    
    private func showDatePicker(){
        viewModel.showDatePicker.subscribe(onNext: { isShow in
            if isShow {
                self.pickerView.isHidden = false
            }
        }).disposed(by: disposeBag)
    }
    
    @IBAction func statusButtonTapped(_ sender: UIButton) {
        self.statusView.isHidden = false
    }
    
    @IBAction func confirmationButtonTapped(_ sender: UIButton) {
        pickerView.isHidden = true
        viewModel.showDatePicker.onNext(false)
        self.viewModel.changeStatus(id: selectedId, statusRent: RentStatus.ongoing.getID())
    }
    
    @IBAction func changeStatusButtonTapped(_ sender: UIButton) {
        statusView.isHidden = true
        viewModel.selectedStatus.onNext(selectedStatus)
    }
}
