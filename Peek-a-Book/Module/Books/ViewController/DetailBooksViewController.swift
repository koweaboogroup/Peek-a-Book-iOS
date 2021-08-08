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
    
    private let cart = DataManager.shared.getCart()
    private var lenderBook: LenderBook?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getDetailBook(id: String(id))
        totalBookButtonView.isHidden = true
        
        setNavigationBar()
        setupCart(cart)
        setupRx()
    }
    
    private func setupCart(_ item: [LenderBook]){
        if !item.isEmpty {
            totalBookButtonView.isHidden = false
            detailTotalBookLabel.text = String(item.count)
        }else{
            totalBookButtonView.isHidden = true
        }
    }
    
    func setupRx() {
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
            "Rp\(book.price?.toRupiah() ?? "")"
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
        print("aww Shit")
    }
    
    @IBAction func totalBukuGetTapped(_ sender: UITapGestureRecognizer) {
        print("aww mantab")
        DataManager.shared.saveCartToUserDefaults()
        
        let vc = ModuleBuilder.shared.goToCheckOutViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func kondisiBukuInformationTouched(_ sender: UIButton) {
        print("Ini dah ngeleg banget bund")
    }
    
    @IBAction func tambahKeranjangButtonPressed(_ sender: UIButton) {
        tambahKeranjangButton.isEnabled = false
        
        //LOGIC IN HERE
        if let lenderBook = lenderBook {
            viewModel.addToCart(cart, lenderBook) { item in
                print("Item \(item.count)")
                self.tambahKeranjangButton.isEnabled = false
                self.setupCart(item)
            } onErrorCompletion: {
                self.tambahKeranjangButton.isEnabled = true
            }
        }
    }
    
    
    
    func setNavigationBar(){
        self.navigationItem.title = "Detail Buku"
        
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "DM Serif Text", size: 19)!]
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
}
