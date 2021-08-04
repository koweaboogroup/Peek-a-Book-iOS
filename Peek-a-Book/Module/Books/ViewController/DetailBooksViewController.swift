//
//  DetailBooksViewController.swift
//  Peek-a-Book
//
//  Created by Gede Wicaksana on 29/07/21.
//

import UIKit
import RxCocoa
import RxSwift

class DetailBooksViewController: UIViewController {

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
    @IBOutlet weak var DetailTotalBookLabel: UILabel!
    @IBOutlet weak var totalBookButtonView: UIView!
    @IBOutlet weak var tambahKeranjangButton: UIButton!
    
    private var viewModel = DetailBookViewModel()
    private var disposeBag = DisposeBag()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        totalBookButtonView.isHidden = true
        
        
        
    

        setNavigationBar()
        setupRx()
    }
    
    func setupRx() {
        // MARK: -Setup Header View
        //jangan lupa binding Book Image
        
        viewModel.bookDetail.asObserver().map { book in
            book.bookTitle
        }.bind(to: detailBookTitleLabel.rx.text)
        .disposed(by: disposeBag)
        
        viewModel.bookDetail.asObserver().map { book in
            book.bookWriter
        }.bind(to: detailBookWriterLabel.rx.text)
        .disposed(by: disposeBag)
        
        //book price blm ada?
        
        // MARK: - Setup Lender Button View
        
        
        
        
        
        
        
        
        // MARK: - Setup Content View
        viewModel.bookDetail.asObserver().map { book in
            book.bookISBN
        }.bind(to: detailBookISBNLabel.rx.text)
        .disposed(by: disposeBag)
        
        //bahasa, halaman, condition blm ada?
        
        viewModel.bookDetail.asObserver().map { book in
            book.bookGenre?.bookGenreName
        }.bind(to: detailBookGenreLabel.rx.text)
        .disposed(by: disposeBag)
        
        viewModel.bookDetail.asObserver().map { book in
            book.bookSinopsis
        }.bind(to: detailBookSinopsisLabel.rx.text)
        .disposed(by: disposeBag)
    }
    
    

    
    @IBAction func lenderProfileGetTapped(_ sender: UITapGestureRecognizer) {
        print("aww Shit")
    }
    
    @IBAction func totalBukuGetTapped(_ sender: UITapGestureRecognizer) {
        print("aww mantab")
    }
    @IBAction func kondisiBukuInformationTouched(_ sender: UIButton) {
        print("Ini dah ngeleg banget bund")
    }
    
    @IBAction func tambahKeranjangButtonPressed(_ sender: UIButton) {
        totalBookButtonView.isHidden = false
        tambahKeranjangButton.isEnabled = false
        print("aww geli")
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
