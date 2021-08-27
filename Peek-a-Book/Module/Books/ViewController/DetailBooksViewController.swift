//
//  DetailBooksViewController.swift
//  Peek-a-Book
//
//  Created by Gede Wicaksana on 29/07/21.
//

import UIKit
import RxCocoa
import RxSwift
import Kingfisher
import RxKingfisher

class DetailBooksViewController: UIViewController {
    
    var id: Int = 0
    
    
    // MARK: -Header View
    @IBOutlet weak var detailBookImages: UIImageView!
    @IBOutlet weak var detailBookTitleLabel: UILabel!
    @IBOutlet weak var detailBookWriterLabel: UILabel!
    @IBOutlet weak var detailBookPriceLabel: UILabel!
    
    // MARK: - Lender Button View
    @IBOutlet weak var lenderImage: UIImageView!
    @IBOutlet weak var lenderStoreNameLabel: UILabel!
    @IBOutlet weak var lenderStoreLocationLabel: UILabel!
    
    // MARK: -Content View
    @IBOutlet weak var detailBookISBNLabel: UILabel!
    @IBOutlet weak var detailBookBahasaLabel: UILabel!
    @IBOutlet weak var detailBookHalamanLabel: UILabel!
    @IBOutlet weak var detailBookGenreLabel: UILabel!
    @IBOutlet weak var detailBookConditionLabel: UILabel!
    @IBOutlet weak var detailBookSinopsisLabel: UILabel!
    
    // MARK: -Bottom View
    @IBOutlet weak var detailTotalBookLabel: UILabel!
    @IBOutlet weak var totalBookButtonView: UIView!
    @IBOutlet weak var tambahKeranjangButton: UIButton!
    
    private var viewModel = DetailBookViewModel()
    private var disposeBag = DisposeBag()
    
    private let dataManager = DataManager.shared
    private var lenderBook: LenderBook?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        viewModel.getDetailBook(id: String(id))
        totalBookButtonView.isHidden = true
        
        setNavigationBar()
        setupCart()
        updateCart()
        
        setupRx()
        
    }
    
    private func updateCart() {
        if !dataManager.getCart().isEmpty {
            totalBookButtonView.isHidden = false
            detailTotalBookLabel.text = String(dataManager.getCart().count)
        } else {
            totalBookButtonView.isHidden = true
        }
    }
    
    private func setupCart() {
        if !dataManager.getCart().isEmpty {
            dataManager.getCart().forEach { item in
                if item.id == id {
                    tambahKeranjangButton.isEnabled = false
                    return
                }
            }
        }
    }
    
    private func setupRx() {
        viewModel.bookDetail.subscribe(onNext: { item in
            self.lenderBook = item
        }).disposed(by: disposeBag)
        
        // MARK: -Setup Header View
        viewModel.bookDetail.subscribe (onNext: { book in
            let url = URL(string: Constant.Network.baseUrl + (book.images?[0].url ?? ""))
            self.detailBookImages.kf.setImage(with: url)
        }).disposed(by: disposeBag)
        
        viewModel.bookDetail.asObserver().map { book in
            book.book?.title
        }.bind(to: detailBookTitleLabel.rx.text)
        .disposed(by: disposeBag)
        
        viewModel.bookDetail.asObserver().map { book in
            book.book?.author
        }.bind(to: detailBookWriterLabel.rx.text)
        .disposed(by: disposeBag)
        
        viewModel.bookDetail.asObserver().map { book in
            "Rp \(book.price?.toRupiah() ?? "")/Minggu"
        }.bind(to: detailBookPriceLabel.rx.text)
        .disposed(by: disposeBag)
        
        // MARK: - Setup Lender Button View
        viewModel.bookDetail.subscribe (onNext: { book in
            let url = URL(string: Constant.Network.baseUrl + (book.lender?.images?[0].url ?? ""))
            self.lenderImage.kf.setImage(with: url)
        }).disposed(by: disposeBag)
        
        viewModel.bookDetail.asObserver().map { book in
            book.lender?.name
        }.bind(to: lenderStoreNameLabel.rx.text)
        .disposed(by: disposeBag)
        
        viewModel.bookDetail.asObserver().map { book in
            book.lender?.kota
        }.bind(to: lenderStoreLocationLabel.rx.text)
        .disposed(by: disposeBag)
        
        
        // MARK: - Setup Content View
        viewModel.bookDetail.asObserver().map { book in
            book.book?.isbn
        }.bind(to: detailBookISBNLabel.rx.text)
        .disposed(by: disposeBag)
        
        viewModel.bookDetail.asObserver().map { book in
            book.language
        }.bind(to: detailBookBahasaLabel.rx.text)
        .disposed(by: disposeBag)
        
        viewModel.bookDetail.asObserver().map { book in
            "\(book.page ?? 0)"
        }.bind(to: detailBookHalamanLabel.rx.text)
        .disposed(by: disposeBag)
        
        viewModel.bookDetail.asObserver().map { book in
            book.bookCondition?.title
        }.bind(to: detailBookConditionLabel.rx.text)
        .disposed(by: disposeBag)
        
        viewModel.bookDetail.asObserver().map { book in
         book.book?.bookGenre == 1 ? "Fiksi" : "Non Fiksi"
         }.bind(to: detailBookGenreLabel.rx.text)
         .disposed(by: disposeBag)
        
        viewModel.bookDetail.asObserver().map { book in
            book.book?.sinopsis
        }.bind(to: detailBookSinopsisLabel.rx.text)
        .disposed(by: disposeBag)
    }
    
    @IBAction func lenderProfileGetTapped(_ sender: UITapGestureRecognizer) {
        print("Sambung ke lender")
    }
    
    @IBAction func totalBukuGetTapped(_ sender: UITapGestureRecognizer) {
        DataManager.shared.saveCartToUserDefaults()
        
        let vc = ModuleBuilder.shared.goToCheckOutViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func kondisiBukuInformationTouched(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        switch detailBookConditionLabel.text {
        case "Seperti Baru":
            alert.title = "Kondisi Buku Seperti Baru"
            alert.message = "Tidak ada coretan, noda, ataupun lipatan pada buku. Halaman utuh dan teks dapat dibaca dengan baik."
        case "Baik":
            alert.title = "Kondisi Buku Baik"
            alert.message = "Sedikit coretan, noda, ataupun lipatan. Halaman utuh dan teks dapat dibaca dengan baik."
        case "Cukup Baik":
            alert.title = "Kondisi Buku Cukup Baik"
            alert.message = "Ada coretan, noda, ataupun lipatan. Kertas sedikit menguning namun teks dapat dibaca dengan baik."
        case "Buku Lama":
            alert.title = "Kondisi Buku Buku Lama"
            alert.message = "Halaman robek, lepas, atau bergelombang. Kertas menguning ataupun terkena noda."
        default:
            alert.title = "Kondisi Buku Tidak Ada"
            alert.message = "Data kondisi buku tidak ditemukan"
        }
        
        alert.addAction(UIAlertAction(title: "Mengerti", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func tambahKeranjangButtonPressed(_ sender: UIButton) {
        if dataManager.isLoggedIn() {
            if dataManager.getCart().isEmpty {
                addItemToCart()
                return
            }
            
            if lenderBook?.lender?.id != dataManager.getCart()[0].lender?.id {
                let alert = UIAlertController(title: "Hapus Keranjang?", message: "Keranjang yang kamu buat sebelumnya akan dihapus", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Hapus", style: .destructive, handler: { action in
                    self.dataManager.deleteCart()
                    self.addItemToCart()
                }))
                
                alert.addAction(UIAlertAction(title: "Kembali", style: .cancel, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
            } else {
                addItemToCart()
            }
        } else {
            tabBarController?.selectedIndex = 1
        }
        
    }
    
    private func addItemToCart() {
        if let lenderBook = lenderBook {
            dataManager.addItemToCart(lenderBook: lenderBook)
            updateCart()
            tambahKeranjangButton.isEnabled = false
        }
    }
    
    private func setNavigationBar(){
        self.navigationItem.title = "Detail Buku"
        
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "DM Serif Text", size: 19)!]
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
    }
}
