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
        setupRx()
    }
    
    func setupRx() {
        // MARK: -Setup Header View
        //jangan lupa binding Book Image
//        let url: Observable<URL> = Observable.create { observer in
//            <#code#>
//        }
        
        let url2 = URL(string: "https://assets.pikiran-rakyat.com/crop/0x946:996x2004/x/photo/2020/06/19/2624712725.jpg")
        
        detailBookImages.kf.setImage(with: url2)
        
//        viewModel.bookDetail.asObservable().map { book in
//            let url = book.images?[0].url
//            detailBookImages.kf.rx.setImage(with: url)
//        )}
//        .subscribe(onNext: { image in
//            print(image)
//        })
//        .disposed(by: disposeBag)
        
        
        viewModel.bookDetail.asObserver().map { book in
            book.book?.title
        }.bind(to: detailBookTitleLabel.rx.text)
        .disposed(by: disposeBag)
        
        viewModel.bookDetail.asObserver().map { book in
            book.book?.author
        }.bind(to: detailBookWriterLabel.rx.text)
        .disposed(by: disposeBag)
        
        viewModel.bookDetail.asObserver().map { book in
            "\(book.price ?? 0)"
        }.bind(to: detailBookWriterLabel.rx.text)
        .disposed(by: disposeBag)
        
        // MARK: - Setup Lender Button View
        
        //lenderImage dipertanyakan Bang Arif
        
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
        
        
        //MARK: -Book Genre blm ada String
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
    }
    @IBAction func kondisiBukuInformationTouched(_ sender: UIButton) {
        print("Ini dah ngeleg banget bund")
    }
    
    @IBAction func tambahKeranjangButtonPressed(_ sender: UIButton) {
        totalBookButtonView.isHidden = false
        tambahKeranjangButton.isEnabled = false
        print("aww geli")
    }
    
  

}
