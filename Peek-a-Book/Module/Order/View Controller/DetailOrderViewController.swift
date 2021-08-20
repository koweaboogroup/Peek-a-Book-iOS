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
    var mulaiSewa: String?
    private var messageStatusPemberiSewaEnum: MessageStatusPemberiSewa?
    private var messageStatusPenyewaEnum: MessageStatusPenyewa?
    
    
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
        
        viewModel.order
            .subscribe(onNext: { item in
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
        viewModel.order.asObserver().map { order in
            order.user?.alamat
            
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
            return "Rp \(totalPrice)"
        }.bind(to: rentFeeLabel.rx.text)
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

        
        //MARK: -Bikin logic pesan header
        
        viewModel.order.asObserver().map { order in
            MessageStatusPenyewa(rawValue: order.status?.name ?? "Menunggu Konfirmasi")?.messageStatusPenyewaSetting(namaPenyewa: self.renterNameLabel.text ?? "", nomorPesanan: self.nomorOrderPenyewaanLabel.text ?? "")
        }.bind(to: informationStatusLabel.rx.text)
        .disposed(by: disposeBag)
        
        viewModel.order
            .subscribe(onNext: { order in
                self.mulaiSewa = order.updatedAt
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
                self.date = dateFormatter.date(from: self.mulaiSewa ?? "")
                self.durasiSewa = order.periodOfTime
            })
            .disposed(by: disposeBag)
        
//        let components = Calendar.current.dateComponents([.year, .month, .day, .hour], from: date)
    }
    
    // MARK: - countdown
    @objc func updateTime() {
        let countdown = self.countdown//only compute once per call
        let days = countdown.day!
    
        if days <= 7 && days > 3{
        }
        else if days <= 3 && days >= 2 {
            
        }
        else if days == 1 {
            
        }
        else if days <= 0 {
            
        }
    }

    func runCountdown() {
        Timer.scheduledTimer(timeInterval: 3600, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @IBAction func lihatAlamatButtonPressed(_ sender: UIButton) {
        let vc = ModuleBuilder.shared.goToModalDetailOrderViewController()
//        vc.nomerTelpPemberiSewaLabel.text = nomerTelponPemberiSewa ?? "08"
        
        present(vc, animated: true, completion: nil)
    }
}

extension DetailOrderViewController {
    private enum MessageStatusPemberiSewa: String {
        case penyewaanBaru = "Menunggu Konfirmasi"
        case penyewaanDibatalkan = "Tidak Selesai"
        case penyewaanTerkonfirmasi = "Dalam Pengiriman"
        case bukuSudahDiterima = "Sedang Berlangsung"
//        case penyewaanSedangBerlangsung = "Sedang Berlangsung"
//        case penyewaanTersisaTigaHari = "Sedang Berlangsung"
        case waktuPenyewaanSudahHabis = "Sedang Dikembalikan"
        case bukuTelahDikembalikan = "Selesai"
        
        
        func messageStatusPemberiSewaSetting(namaPenyewa: String, nomorPesanan: String) -> String {
            
            switch self {
            case .penyewaanBaru:
                return "Anda menerima permintaan penyewaan baru dari \(namaPenyewa). Terima penyewaan?"
            case .penyewaanDibatalkan:
                return "Penyewaan (nomor pesanan) sudah dibatalkan oleh (nama penyewa)."
            case .penyewaanTerkonfirmasi:
                return "Jangan lupa mengirimkan buku untuk penyewaan (nomor penyewaan). Mohon konfirmasi di halaman Kelola Penyewaan jika buku sudah dikirimkan."
            case .bukuSudahDiterima:
                return "Jangan lupa mengirimkan buku untuk penyewaan (nomor penyewaan). Mohon konfirmasi di halaman Kelola Penyewaan jika buku sudah dikirimkan."
//            case .penyewaanSedangBerlangsung:
//                return "Penyewaan (nomor penyewaan) sedang berlangsung hingga tanggal (deadline penyewaan)."
//            case .penyewaanTersisaTigaHari:
//                return "Pastikan (nama Penyewa) mengembalikan buku sebelum tanggal (due date + 1).)"
            case .waktuPenyewaanSudahHabis:
                return "Pastikan (nama Penyewa) mengembalikan buku hari Ini."
            case .bukuTelahDikembalikan:
                return "Penyewaan (nomor penyewaan) sudah dikirimkan oleh (nama Penyewa). Mohon konfirmasi di halaman Kelola Penyewaan jika buku sudah diterima."
            }
        }

    }
    private enum MessageStatusPenyewa: String{
        case menungguKonfirmasi = "Menunggu Konfirmasi"
        case penyewaanDitolak = "Tidak Selesai"
        case penyewaanDikonfirmasi = "Dalam Pengiriman"
//        case bukuTelahDikirim = "Sedang Berlangsung"
        case penyewaanSedangBerlangsung = "Sedang Berlangsung"
//        case penyewaanTersisaTujuhHariLagi
//        case penyewaanTersisaTigaHariLagi
        case waktuPenyewaanSudahHabis
        case waktuPenyewaanSudahLewat
        case penyewaanSudahSelesai
        
        func messageStatusPenyewaSetting(namaPenyewa: String, nomorPesanan: String) -> String {
            
            
            switch self {
            case .menungguKonfirmasi:
                return "Penyewaan (nomor penyewaan) sedang menunggu konfirmasi dari (nama toko Pemberi Sewa). "
            case .penyewaanDitolak:
                return "Penyewaan (nomor penyewaan) ditolak oleh (nama Pemberi Sewa)"
            case .penyewaanDikonfirmasi:
                return "Penyewaan (nomor penyewaan) sudah dikonfirmasi oleh (nama Pemberi Sewa). Mohon menunggu (nama Pemberi Sewa) menghubungi nomor Anda."
//            case .bukuTelahDikirim:
//                return "Penyewaan (nomor penyewaan) sudah dikirimkan oleh (nama Pemberi Sewa). Mohon konfirmasi di halaman Riwayat Penyewaan jika buku sudah diterima."
            case .penyewaanSedangBerlangsung:
                return "Penyewaan (nomor penyewaan) sedang berlangsung hingga tanggal (deadline penyewaan)."
//            case .penyewaanTersisaTujuhHariLagi:
//                return "Jangan lupa menyelesaikan buku Anda, dan harap mengembalikan buku maksimal tanggal (tanggal due date + 1)."
//            case .penyewaanTersisaTigaHariLagi:
//                return "Jangan lupa menyelesaikan buku Anda, dan harap mengembalikan buku maksimal tanggal (tanggal due date + 1)."
            case .waktuPenyewaanSudahHabis:
                return "Anda harus mengembalikan penyewaan (nomor penyewaan) hari ini. Mohon konfirmasi di halaman Riwayat Penyewaan jika buku sudah dikembalikan."
            case .waktuPenyewaanSudahLewat:
                return "Anda belum mengembalikan penyewaan (nomor penyewaan). Jangan sampai terkena denda karena telat mengembalikan."
            case .penyewaanSudahSelesai:
                return "Buku dari penyewaan (nomor penyewaaan) sudah diterima oleh (Nama toko Pemberi Sewa). Terima kasih karena sudah menyelesaikan penyewaan Anda."
            }
        }
        
        
    }
}
