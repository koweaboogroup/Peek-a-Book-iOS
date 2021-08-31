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
    
    var nomerTelponPemberiSewa: String?
    var durasiSewa: Int?
    var mulaiSewa: String = ""
    var userPenyewa: Bool = true
    private var messageStatusTemp: String?
    
    
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
    @IBOutlet weak var profileImage: CircleImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var detailBukuTableView: UITableView!
    @IBOutlet weak var detailBukuTableHeight: NSLayoutConstraint!
    
    // MARK: - Detail Sewa
    @IBOutlet weak var rentDurationLabel: UILabel!
    @IBOutlet weak var rentDeliveryMethodLabel: UILabel!
    @IBOutlet weak var rentDeliveryFeeLabel: UILabel!
    @IBOutlet weak var rentFeeLabel: UILabel!
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        self.detailBukuTableHeight?.constant = self.detailBukuTableView.contentSize.height - 4
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewWillLayoutSubviews()
    }
    
    private var order: Rent?
    private var orderId: Int?
    private let viewModel = DetailOrderViewModel()
    private let disposeBag = DisposeBag()
    
    func setOrderId(orderId: Int) {
        self.orderId = orderId
    }
    
    var date: Date?
    
    let futureDate: Date = {
        var future = DateComponents(
            year: 2021,
            month: 8,
            day: 30
        )
        return Calendar.current.date(from: future)!
    }()
    
    var countdown: DateComponents {
        return Calendar.current.dateComponents([.day, .hour], from: Date(), to: futureDate)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setRx()
        viewModel.getDetailOrder(orderId: orderId ?? -1)
        setNavigationBar()
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(DetailOrderViewController.back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
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
    
    
    private func setRx() {
        //Header
        rentDeliveryFeeLabel.text = "Rp 0"
        viewModel.order
            .subscribe(onNext: { item in
                self.order = item
                self.viewModel.getProfile(userId: item.lenderBooks?[0].lender?.user ?? -1)
            })
            .disposed(by: disposeBag)
        
        viewModel.user
            .subscribe(onNext: { profile in
                self.nomerTelponPemberiSewa = profile.phoneNumber
            })
            .disposed(by: disposeBag)
        
        viewModel.order.asObserver().map { order in
            "No Order Penyewaan: \(order.id ?? -1)"
        }.bind(to: nomorOrderPenyewaanLabel.rx.text)
        .disposed(by: disposeBag)
        
        //Detail penyewa
        
        viewModel.order.asObserver().map { order in
            order.user?.username
        }.bind(to: renterNameLabel.rx.text)
        .disposed(by: disposeBag)
        
        viewModel.order.asObserver().map { order in
            order.alamat
        }.bind(to: renterStreetLabel.rx.text)
        .disposed(by: disposeBag)
        
        viewModel.order.asObserver().map { order in
            order.kelurahan
        }.bind(to: renterSubDistrictLabel.rx.text)
        .disposed(by: disposeBag)
        
        viewModel.order.asObserver().map { order in
            order.kecamatan
        }.bind(to: renterDistrictLabel.rx.text)
        .disposed(by: disposeBag)
        
        viewModel.order.asObserver().map { order in
            order.provinsi
        }.bind(to: renterCountryLabel.rx.text)
        .disposed(by: disposeBag)
        
        viewModel.order.asObserver().map { order in
            order.user?.phoneNumber
        }.bind(to: renterPhoneLabel.rx.text)
        .disposed(by: disposeBag)
        
        //Detail buku
        viewModel.order.subscribe(onNext: { order in
            self.profileImage.setImage(fromUrl: Constant.Network.baseUrl + (order.lenderBooks?[0].lender?.images?[0].url ?? ""))
        }).disposed(by: disposeBag)
        
        
        viewModel.order.asObserver().map { order in
            order.lenderBooks?[0].lender?.name
        }.bind(to: profileNameLabel.rx.text)
        .disposed(by: disposeBag)
        
        
        //Detail sewa
        
        viewModel.order.asObserver().map { order in
            "\(order.periodOfTime ?? -1) Minggu"
        }.bind(to: rentDurationLabel.rx.text)
        .disposed(by: disposeBag)
        
        viewModel.order.asObserver().map { order in
            Shipment(rawValue: order.shippingMethods ?? "cod")?.getTitle()
        }.bind(to: rentDeliveryMethodLabel.rx.text)
        .disposed(by: disposeBag)
        
        viewModel.order.asObserver().map { order in
            var totalPrice = 0
            let items: [LenderBook] = order.lenderBooks ?? []
            for item in items{
                totalPrice += item.price ?? 0
            }
            
            totalPrice *= order.periodOfTime ?? 0
            
            return "Rp \(totalPrice)"
        }.bind(to: rentFeeLabel.rx.text)
        .disposed(by: disposeBag)
        
        detailBukuTableView.register(UINib(nibName: XIBConstant.ItemKeranjangTableViewCell, bundle: nil), forCellReuseIdentifier: String(describing: ItemKeranjangTableViewCell.self))
        
        viewModel.order.asObservable().map{ order in
            order.lenderBooks ?? []
        }.bind(to: detailBukuTableView.rx.items(cellIdentifier: "ItemKeranjangTableViewCell", cellType: ItemKeranjangTableViewCell.self)){(row, lenderBook, cell) in
            if let image = lenderBook.images {
                if !image.isEmpty {
                    let url = URL(string: Constant.Network.baseUrl + (image[0].url ?? ""))
                    cell.bookImage.kf.setImage(with: url)
                }else{
                    cell.bookImage.image = UIImage (systemName: "book.fill")
                }
            }else{
                cell.bookImage.image = UIImage (systemName: "book.fill")
            }
            cell.bookTitle.text = lenderBook.book?.title
            cell.bookWriter.text = lenderBook.book?.author
            
        }.disposed(by: disposeBag)
        
        
        //MARK: -Bikin logic pesan header
        if self.userPenyewa == true{
            viewModel.order.asObserver().map { order in
                MessageStatusPenyewa(rawValue: order.status?.name ?? "Dalam Proses")?.messageStatusPenyewaSetting(namaTokoPemberiSewa: self.profileNameLabel.text ?? "", nomorPesanan: self.nomorOrderPenyewaanLabel.text ?? "", getStatus: self.messageStatusTemp ?? "Penyewaan \(String(describing: self.nomorOrderPenyewaanLabel.text ?? "1")) sedang berlangsung hingga tanggal 17/9/2021.")
            }.bind(to: informationStatusLabel.rx.text)
            .disposed(by: disposeBag)
        }
        else {
            viewModel.order.asObserver().map { order in
                MessageStatusPemberiSewa(rawValue: order.status?.name ?? "Dalam Proses")?.messageStatusPemberiSewaSetting(namaPenyewa: self.profileNameLabel.text ?? "", nomorPesanan: self.nomorOrderPenyewaanLabel.text ?? "", getStatus: self.messageStatusTemp ?? "Penyewaan \(String(describing: self.nomorOrderPenyewaanLabel.text ?? "1")) sedang berlangsung hingga tanggal 17/9/2021.")
            }.bind(to: informationStatusLabel.rx.text)
            .disposed(by: disposeBag)
        }
        
        
        
        
        
        
        
        viewModel.order
            .subscribe(onNext: { order in
                let ISOdate = order.updatedAt ?? ""
                let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                self.date = dateFormatter.date(from: ISOdate)
                self.durasiSewa = order.periodOfTime
            })
            .disposed(by: disposeBag)
        
    }
    
    // MARK: - countdown
    @objc func updateTime() {
        let countdown = self.countdown
        let day = countdown.day!
        
        if day <= 7 {
            if day <= 3 && day >= 2{
                if userPenyewa {
                    messageStatusTemp = "Jangan lupa menyelesaikan buku Anda, dan harap mengembalikan buku maksimal tanggal \(String(describing: date))."
                }
                else {
                    messageStatusTemp = "Pastikan \(String(describing: renterNameLabel)) mengembalikan buku sebelum tanggal \(String(describing: date)).)"
                }
            }
            else if day == 1 {
                if userPenyewa {
                    messageStatusTemp = "Jangan lupa menyelesaikan buku Anda, dan harap mengembalikan buku maksimal tanggal \(String(describing: date))."
                }
                else {
                    messageStatusTemp = "Jangan lupa menyelesaikan buku Anda, dan harap mengembalikan buku maksimal tanggal \(String(describing: date))."
                }
            }
            else if day == 0 {
                if userPenyewa {
                    messageStatusTemp = "Anda harus mengembalikan penyewaan \(String(describing: nomorOrderPenyewaanLabel)) hari ini. Mohon konfirmasi di halaman Riwayat Penyewaan jika buku sudah dikembalikan."
                }
                else {
                    
                }
            }
            if userPenyewa{
                messageStatusTemp = "Jangan lupa menyelesaikan buku Anda, dan harap mengembalikan buku maksimal tanggal \(String(describing: date))."
            }
            else{
                messageStatusTemp = "Penyewaan \(String(describing: nomorOrderPenyewaanLabel)) sedang berlangsung hingga tanggal \(String(describing: date))."
            }
        }
        messageStatusTemp = "Penyewaan \(String(describing: nomorOrderPenyewaanLabel)) sedang berlangsung hingga tanggal \(String(describing: date))."
    }
    
    func runCountdown() {
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @IBAction func lihatAlamatButtonPressed(_ sender: UIButton) {
        let vc = ModuleBuilder.shared.goToModalDetailOrderViewController()
        vc.order = order
        vc.nomerTelpPemberiSewa = nomerTelponPemberiSewa ?? "08"
        
        present(vc, animated: true, completion: nil)
    }
    
    @objc func back(sender: UIBarButtonItem) {
        if userPenyewa{
            self.navigationController?.popToRootViewController(animated: true)
        }
        else{
            self.navigationController?.popViewController(animated: true)
        }
    }
}






extension DetailOrderViewController {
    private enum MessageStatusPemberiSewa: String {
        case penyewaanBaru = "Dalam Proses"
        case penyewaanDibatalkan = "Tidak Selesai"
        case penyewaanTerkonfirmasi = "Dalam Pengiriman"
        case bukuSudahDiterima = "Sedang Berlangsung"
        case waktuPenyewaanSudahHabis = "Sedang Dikembalikan"
        case bukuTelahDikembalikan = "Selesai"
        
        
        func messageStatusPemberiSewaSetting(namaPenyewa: String, nomorPesanan: String, getStatus: String) -> String {
            
            switch self {
            case .penyewaanBaru:
                return "Anda menerima permintaan penyewaan baru dari \(namaPenyewa). Terima penyewaan?"
            case .penyewaanDibatalkan:
                return "Penyewaan \(nomorPesanan) sudah dibatalkan oleh \(namaPenyewa)."
            case .penyewaanTerkonfirmasi:
                return "Jangan lupa mengirimkan buku untuk penyewaan \(nomorPesanan). Mohon konfirmasi di halaman Kelola Penyewaan jika buku sudah dikirimkan."
            case .bukuSudahDiterima:
                return getStatus
            case .waktuPenyewaanSudahHabis:
                return "Pastikan \(namaPenyewa) mengembalikan buku hari Ini."
            case .bukuTelahDikembalikan:
                return "Penyewaan \(nomorPesanan) sudah dikirimkan oleh \(namaPenyewa). Mohon konfirmasi di halaman Kelola Penyewaan jika buku sudah diterima."
            }
        }
        
    }
    private enum MessageStatusPenyewa: String{
        case menungguKonfirmasi = "Dalam Proses"
        case penyewaanDitolak = "Tidak Selesai"
        case penyewaanDikonfirmasi = "Dalam Pengiriman"
        case penyewaanSedangBerlangsung = "Sedang Berlangsung"
        case waktuPenyewaanSudahHabis
        case waktuPenyewaanSudahLewat
        case penyewaanSudahSelesai
        
        func messageStatusPenyewaSetting(namaTokoPemberiSewa: String, nomorPesanan: String, getStatus: String) -> String {
            
            
            switch self {
            case .menungguKonfirmasi:
                return "Penyewaan \(nomorPesanan) sedang menunggu konfirmasi dari \(namaTokoPemberiSewa). "
            case .penyewaanDitolak:
                return "Penyewaan \(nomorPesanan) ditolak oleh \(namaTokoPemberiSewa)"
            case .penyewaanDikonfirmasi:
                return "Penyewaan \(nomorPesanan) sudah dikonfirmasi oleh \(namaTokoPemberiSewa). Mohon menunggu \(namaTokoPemberiSewa) menghubungi nomor Anda."
            case .penyewaanSedangBerlangsung:
                return getStatus
            case .waktuPenyewaanSudahHabis:
                return "Anda harus mengembalikan penyewaan \(nomorPesanan) hari ini. Mohon konfirmasi di halaman Riwayat Penyewaan jika buku sudah dikembalikan."
            case .waktuPenyewaanSudahLewat:
                return "Anda belum mengembalikan penyewaan \(nomorPesanan). Jangan sampai terkena denda karena telat mengembalikan."
            case .penyewaanSudahSelesai:
                return "Buku dari penyewaan \(nomorPesanan) sudah diterima oleh \(namaTokoPemberiSewa). Terima kasih karena sudah menyelesaikan penyewaan Anda."
            }
        }
        
        
    }
}
