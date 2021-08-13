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
    @IBOutlet weak var biayaOngkirLabel: NSLayoutConstraint!
    @IBOutlet weak var estimasiTotalLabel: UILabel!
    
    //MARK: -Button
    @IBOutlet weak var sewaSekarangButton: UIButton!
    @IBOutlet weak var pickerReuse: UIPickerView!
    @IBOutlet weak var pickerTitle: UILabel!
    @IBOutlet weak var pickerFullView: UIView!
    
    
    let disposeBag = DisposeBag()
    var durasiSewa = Observable.of(["Row1", "Row2", "Row3"])
    var items: Observable<[String]> = Observable.of([])
    
    private let cart: [LenderBook] = DataManager.shared.getCart()
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        self.tableHeight?.constant = self.detailBukuTableView.contentSize.height - 4
    
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewWillLayoutSubviews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        lenderImageView.image = #imageLiteral(resourceName: "store")
        setupView()
        setupPicker()
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

    private func setupView(){
        let lenderName = cart[0].lender?.name
        let lenderImage = Constant.Network.baseUrl + (cart[0].lender?.images?[0].url ?? "")
        
        lenderNameLabel.text = lenderName
        detailBukuTableView.register(UINib(nibName: XIBConstant.ItemKeranjangTableViewCell, bundle: nil), forCellReuseIdentifier: "ItemKeranjangTableViewCell")
        detailBukuTableView.dataSource = self
        
        var price = 0
        for item in cart {
            if let priceCart = item.price {
                price = price + priceCart
            }
        }
        
        hargaPenyewaanLabel.text = "Rp. \(price.toRupiah())/minggu"
        biayaSewaBukuLabel.text = "Rp. \(price.toRupiah())"
        
        

    }
    
    private func setupPicker(){
        pickerFullView.isHidden = true
        items = durasiSewa
        
        items.bind(to: pickerReuse.rx.itemTitles) { (row, element) in
            return element
        }
        .disposed(by: disposeBag)

        pickerReuse.rx.modelSelected(String.self)
            .subscribe(onNext: { models in
                print("models selected 1: \(models)")
            })
            .disposed(by: disposeBag)
        pickerReuse.selectRow(1, inComponent: 0, animated: true)
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
        pickerFullView.isHidden = false
    }
    
    @IBAction func detailAlamatGetTapped(_ sender: UITapGestureRecognizer) {
        pickerFullView.isHidden = false
    }
    
    @IBAction func metodePengirimanGetTapped(_ sender: UITapGestureRecognizer) {
        print("Picker")
    }
    
    @IBAction func sewaSekarangButtonPressed(_ sender: UIButton) {
        print("cabut")
    }
    
    @IBAction func donePickerButtonPressed(_ sender: UIButton){
        pickerFullView.isHidden = true
    }
}
