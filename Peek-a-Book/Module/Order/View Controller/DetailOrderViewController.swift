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

    private enum messageStatusPemberiSewa {
        case penyewaanBaru, penyewaanDibatalkan, penyewaanTerkonfirmasi, bukuSudahDiterima, penyewaanSedangBerlangsung, penyewaanTersisaTigaHari, waktuPenyewaanSudahHabis, bukuTelahDikembalikan
    }
    
    private enum messageStatusPenyewa {
        case menungguKonfirmasi, penyewaanDitolak, penyewaanDikonfirmasi, bukuTelahDikirim, penyewaanSedangBerlangsung, penyewaanTersisaTujuhHariLagi, penyewaanTersisaTigaHariLagi, waktuPenyewaanSudahHabis, waktuPenyewaanSudahLewat, penyewaanSudahSelesai
    }
    
    private var messageStatusPemberiSewaEnum: messageStatusPemberiSewa?
    private var messageStatusPenyewaEnum: messageStatusPenyewa?
    
    
    
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
    @IBOutlet var detailBukuTableHeight: NSLayoutConstraint!
    
    // MARK: - Detail Sewa
    @IBOutlet weak var durasiSewaLabel: UILabel!
    @IBOutlet weak var metodePengirimanLabel: UILabel!
    @IBOutlet weak var biayaPengirimanLabel: UILabel!
    @IBOutlet weak var totalBiayaLabel: UILabel!
    @IBOutlet weak var tanggalBatasSewaLabel: UILabel!
    
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
    
    
    
    
    func setNavigationBar(){
        self.navigationItem.title = "Detail Order"
        
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "DM Serif Text", size: 19)!]
        
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "DM Serif Text", size: 19.0)!], for: .normal)
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
    func setView(){
        detailBukuTableView.layer.applyShadow(color: .black, alpha: 0.1, x: 0, y: 2, blur: 5, spread: 0)
    }
    
    
    func setRx(){
        viewModel.getDetailOrder(orderId: orderId ?? -1)
    
        //Header
        
        viewModel.order.asObserver().map { order in
            "No Order Penyewaan: \(order.id ?? -1)"
        }.bind(to: nomorOrderPenyewaanLabel.rx.text)
        .disposed(by: disposeBag)
        
        //Detail penyewa
        
        viewModel.order.asObserver().map { order in
            order.rent?.user?.username
        }.bind(to: namaPenyewaLabel.rx.text)
        .disposed(by: disposeBag)
        
        viewModel.order.asObserver().map { order in
            order.rent?.alamat
        }.bind(to: jalanPenyewaLabel.rx.text)
        .disposed(by: disposeBag)
        
        viewModel.order.asObserver().map { order in
            order.rent?.kelurahan
        }.bind(to: kelurahanPenyewaLabel.rx.text)
        .disposed(by: disposeBag)
        
        viewModel.order.asObserver().map { order in
            order.rent?.kecamatan
        }.bind(to: kecamatanPenyewaLabel.rx.text)
        .disposed(by: disposeBag)
        
        viewModel.order.asObserver().map { order in
            order.rent?.provinsi
        }.bind(to: negaraPenyewaLabel.rx.text)
        .disposed(by: disposeBag)
        
        viewModel.order.asObserver().map { order in
            order.rent?.user?.phoneNumber
        }.bind(to: nomorTeleponPenyewaLabel.rx.text)
        .disposed(by: disposeBag)
        
        //Detail buku
        viewModel.order.asObserver().map { order in
            order.rent?.user?.alamat
            
        }.bind(to: profileNameLabel.rx.text)
        .disposed(by: disposeBag)
        
        
        //Detail sewa
        
        viewModel.order.asObserver().map { order in
            "\(order.rent?.periodOfTime ?? -1)"
        }.bind(to: durasiSewaLabel.rx.text)
        .disposed(by: disposeBag)
        
        viewModel.order.asObserver().map { order in
            order.rent?.shippingMethods
        }.bind(to: metodePengirimanLabel.rx.text)
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
    
    
    func swcase(){
        switch messageStatusPemberiSewaEnum {
        case .penyewaanBaru:
            print("Anda menerima permintaan penyewaan baru dari (nama penyewa). Terima penyewaan?")
        case .penyewaanDibatalkan:
            print("Penyewaan (nomor pesanan) sudah dibatalkan oleh (nama penyewa).")
        case .penyewaanTerkonfirmasi:
            print("Jangan lupa mengirimkan buku untuk penyewaan (nomor penyewaan). Mohon konfirmasi di halaman Kelola Penyewaan jika buku sudah dikirimkan.")
        case .bukuSudahDiterima:
            print("Jangan lupa mengirimkan buku untuk penyewaan (nomor penyewaan). Mohon konfirmasi di halaman Kelola Penyewaan jika buku sudah dikirimkan.")
        case .penyewaanSedangBerlangsung:
            print("Penyewaan (nomor penyewaan) sedang berlangsung hingga tanggal (deadline penyewaan).")
        case .penyewaanTersisaTigaHari:
            print("Pastikan (nama Penyewa) mengembalikan buku sebelum tanggal (due date + 1).)")
        case .waktuPenyewaanSudahHabis:
            print("Pastikan (nama Penyewa) mengembalikan buku hari Ini.")
        case .bukuTelahDikembalikan:
            print("Penyewaan (nomor penyewaan) sudah dikirimkan oleh (nama Penyewa). Mohon konfirmasi di halaman Kelola Penyewaan jika buku sudah diterima.")
        default:
            print("Error")
        }
        
        switch messageStatusPenyewaEnum {
        case .menungguKonfirmasi:
            print("Penyewaan (nomor penyewaan) sedang menunggu konfirmasi dari (nama toko Pemberi Sewa). ")
        case .penyewaanDitolak:
            print("Penyewaan (nomor penyewaan) ditolak oleh (nama Pemberi Sewa)")
        case .penyewaanDikonfirmasi:
            print("Penyewaan (nomor penyewaan) sudah dikonfirmasi oleh (nama Pemberi Sewa). Mohon menunggu (nama Pemberi Sewa) menghubungi nomor Anda.")
        case .bukuTelahDikirim:
            print("Penyewaan (nomor penyewaan) sudah dikirimkan oleh (nama Pemberi Sewa). Mohon konfirmasi di halaman Riwayat Penyewaan jika buku sudah diterima.")
        case .penyewaanSedangBerlangsung:
            print("Penyewaan (nomor penyewaan) sedang berlangsung hingga tanggal (deadline penyewaan).")
        case .penyewaanTersisaTujuhHariLagi:
            print("Jangan lupa menyelesaikan buku Anda, dan harap mengembalikan buku maksimal tanggal (tanggal due date + 1).")
        case .penyewaanTersisaTigaHariLagi:
            print("Jangan lupa menyelesaikan buku Anda, dan harap mengembalikan buku maksimal tanggal (tanggal due date + 1).")
        case .waktuPenyewaanSudahHabis:
            print("Anda harus mengembalikan penyewaan (nomor penyewaan) hari ini. Mohon konfirmasi di halaman Riwayat Penyewaan jika buku sudah dikembalikan.")
        case .waktuPenyewaanSudahLewat:
            print("Anda belum mengembalikan penyewaan (nomor penyewaan). Jangan sampai terkena denda karena telat mengembalikan.")
        case .penyewaanSudahSelesai:
            print("Buku dari penyewaan (nomor penyewaaan) sudah diterima oleh (Nama toko Pemberi Sewa). Terima kasih karena sudah menyelesaikan penyewaan Anda.")
        default:
            print("Error")
        }
    }
    


    @IBAction func kembaliKeHomepagePressed(_ sender: UIButton) {
        print("To homepage")
        
    }
    
    @IBAction func buttonLihatAlamatPressed(_ sender: UIButton) {
    }

}
