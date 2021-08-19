//
//  CheckOutViewController.swift
//  Peek-a-Book
//
//  Created by Gede Wicaksana on 04/08/21.
//

import UIKit
import RxSwift
import RxCocoa

class CheckOutViewController: UIViewController, UITableViewDataSource {
    
    //MARK: -Header
    @IBOutlet weak var lenderImageView: UIImageView!
    @IBOutlet weak var lenderNameLabel: UILabel!
    @IBOutlet weak var detailBukuTableView: UITableView!
    @IBOutlet var tableHeight: NSLayoutConstraint!
    
    //MARK: -Durasi Penyewaan
    @IBOutlet weak var durasiPenyewaanLabel: UILabel!
    @IBOutlet weak var hargaPenyewaanLabel: UILabel!
    
    //MARK: -Detail Pengiriman
    @IBOutlet weak var detailAlamatLabel: UILabel!
    @IBOutlet weak var metodePengirimanLabel: UILabel!
    
    //MARK: -Total Biaya Sewa
    @IBOutlet weak var biayaSewaBukuLabel: UILabel!
    @IBOutlet weak var biayaOngkirLabel: UILabel!
    @IBOutlet weak var estimasiTotalLabel: UILabel!
    
    //MARK: -Button
    @IBOutlet weak var sewaSekarangButton: UIButton!
    @IBOutlet weak var pickerDurasiSewa: UIPickerView!
    @IBOutlet weak var pickerMetodePengiriman: UIPickerView!
    @IBOutlet weak var pickerTitle: UILabel!
    @IBOutlet weak var pickerFullView: UIView!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    let disposeBag = DisposeBag()
    
    var itemsDurasiSewa: Observable<[String]> = Observable.of(["1 Minggu", "2 Minggu", "3 Minggu", "4 Minggu"])
    
    var itemsMetodePengiriman: Observable<[String]> = Observable.of(["Pilih","Kurir", "Self Pickup", "COD"])
    
    private let dataManager = DataManager.shared
    
    private let cart: [LenderBook] = DataManager.shared.getCart()
    
    private let viewModel = CheckoutViewModel()
    private let addressViewModel = AddressViewModel()
    
    private var address = ""
    private var urbanVillage = ""
    private var districtName = ""
    private var cityName = ""
    private var provName = ""
    private var periodOfTime = 1
    private var shippingMethod = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        lenderImageView.image = #imageLiteral(resourceName: "store")
        setupView()
        setupRx()
    }
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        self.tableHeight?.constant = self.detailBukuTableView.contentSize.height - 4
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewWillLayoutSubviews()
    }
    
    private func goToAddressSettingViewController() {
        let vc = ModuleBuilder.shared.goToAlamatViewController()
        vc.initViewModel(viewModel: addressViewModel)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupNavigationBar(){
        self.navigationItem.title = "Keranjang"
        
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "DM Serif Text", size: 19)!]
        
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "DM Serif Text", size: 19.0)!], for: .normal)
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
    private func setupView() {
        
        let lenderName = cart[0].lender?.name
        let lenderImage = Constant.Network.baseUrl + (cart[0].lender?.images?[0].url ?? "")
        
        lenderNameLabel.text = lenderName
        detailBukuTableView.register(UINib(nibName: XIBConstant.ItemKeranjangTableViewCell, bundle: nil), forCellReuseIdentifier: "ItemKeranjangTableViewCell")
        detailBukuTableView.dataSource = self
        
        //MARK: - Setup Picker
        
        pickerFullView.isHidden = true
        pickerDurasiSewa.isHidden = true
        pickerMetodePengiriman.isHidden = true
        
        pickerDurasiSewa.selectRow(0, inComponent: 0, animated: true)
        
        pickerMetodePengiriman.selectRow(0, inComponent: 0, animated: true)
    }
    
    private func setupRx() {
        
        var itemsPrice = 0
        
        viewModel.itemsPrice
            .map { itemsPrice in
                "Rp\(itemsPrice.toRupiah())/minggu"
            }
            .bind(to: hargaPenyewaanLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.bookRentalFee
            .map { bookRentalFee in
                "Rp\(bookRentalFee.toRupiah())"
            }
            .bind(to: biayaSewaBukuLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.feeTotalEstimation
            .map { feeTotalEstimation in
                "Rp\(feeTotalEstimation.toRupiah())"
            }
            .bind(to: estimasiTotalLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.periodOfTime
            .map { periodOfTime in
                "\(periodOfTime) Minggu"
            }
            .bind(to: durasiPenyewaanLabel.rx.text)
            .disposed(by: disposeBag)
        
        
        itemsDurasiSewa
            .bind(to: pickerDurasiSewa.rx.itemTitles) { (row, element) in
                return element
            }
            .disposed(by: disposeBag)
        
        pickerDurasiSewa.rx.itemSelected
            .subscribe(onNext: { (row, _) in
                self.periodOfTime = row + 1
                self.viewModel.periodOfTime.onNext(row + 1)
                self.viewModel.bookRentalFee.onNext(itemsPrice * (row + 1))
            })
            .disposed(by: disposeBag)
        
        itemsMetodePengiriman
            .bind(to: pickerMetodePengiriman.rx.itemTitles) { (row, element) in
                return element
            }
            .disposed(by: disposeBag)
        
        pickerMetodePengiriman.rx
            .modelSelected(String.self)
            .subscribe(onNext: { value in
                if value.joined() != "Pilih" {
//                    self.shippingMethod = Shipment(rawValue: value.joined())?.getServerAttributeName() ?? "cod"
                    self.viewModel.shippingMethod.onNext(value.joined())
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.shippingMethod
            .bind(to: metodePengirimanLabel.rx.text)
            .disposed(by: disposeBag)
        
        addressViewModel.getAllAddressFieldsObservable()
            .subscribe(onNext: {
                self.address = $0[0]
                self.urbanVillage = $0[1]
                self.districtName = $0[2]
                self.cityName = $0[3]
                self.provName = $0[4]
            })
            .disposed(by: disposeBag)
        
        addressViewModel.address
            .bind(to: addressLabel.rx.text)
            .disposed(by: disposeBag)
        
        Observable.combineLatest(viewModel.isAllFieldsFilled(), addressViewModel.isAllAddressFieldsFilled())
            .map { checkoutFields, addressTextFields in
                return checkoutFields && addressTextFields
            }
            .bind(to: sewaSekarangButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        Observable.combineLatest(viewModel.isAllFieldsFilled(), addressViewModel.isAllAddressFieldsFilled())
            .map { checkoutFields, addressTextFields in
                return checkoutFields && addressTextFields
            }
            .map {
                $0 ? 1 : 0.5
            }
            .bind(to: sewaSekarangButton.rx.alpha)
            .disposed(by: disposeBag)
        
        
        for item in cart {
            if let itemPrice = item.price {
                itemsPrice += itemPrice
            }
        }
        
        viewModel.periodOfTime.onNext(1)
        viewModel.feeTotalEstimation.onNext(itemsPrice)
        viewModel.itemsPrice.onNext(itemsPrice)
        viewModel.bookRentalFee.onNext(itemsPrice)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = detailBukuTableView.dequeueReusableCell(withIdentifier: "ItemKeranjangTableViewCell", for: indexPath) as! ItemKeranjangTableViewCell
        cell.response = cart[indexPath.row]
        return cell
    }
    
    //MARK: - Button Setup
    
    @IBAction func durasiPenyewaanGetTapped(_ sender: UITapGestureRecognizer) {
        pickerTitle.text = "Durasi Penyewaan"
        pickerDurasiSewa.isHidden = false
        pickerMetodePengiriman.isHidden = true
        pickerFullView.isHidden = false
    }
    
    @IBAction func detailAlamatGetTapped(_ sender: UITapGestureRecognizer) {
        goToAddressSettingViewController()
    }
    
    @IBAction func metodePengirimanGetTapped(_ sender: UITapGestureRecognizer) {
        pickerTitle.text = "Metode Pengiriman"
        pickerDurasiSewa.isHidden = true
        pickerMetodePengiriman.isHidden = false
        pickerFullView.isHidden = false
    }
    
    @IBAction func donePickerButtonPressed(_ sender: UIButton){
        pickerFullView.isHidden = true
    }
    
    @IBAction func sewaSekarangButtonPressed(_ sender: UIButton) {
        let rentRequest = RentRequest(periodOfTime: periodOfTime, user: dataManager.getUser()?.id ?? -1, shippingMethods: shippingMethod, status: "3", alamat: address, provinsi: provName, kota: cityName, kelurahan: urbanVillage, kecamatan: districtName, longtitude: 0, latitude: 0, lenderBooks: cart)

//        viewModel.createNewRent(rentRequest: rentRequest) { orderId in}
        let vc = ModuleBuilder.shared.goToDetailOrderViewController()
        
        vc.setOrderId(orderId: 3)

    }
        
}
