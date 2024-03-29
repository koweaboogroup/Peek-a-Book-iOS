//
//  ProfileTokoViewController.swift
//  Peek-a-Book
//
//  Created by Gede Wicaksana on 05/08/21.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher
import RxKingfisher

class ProfileLenderViewController: UIViewController, UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var circleLenderImageView: CircleImageView!
    @IBOutlet weak var lenderNameLabel: UILabel!
    @IBOutlet weak var lenderBioLabel: UILabel!
    @IBOutlet weak var lenderLocationLabel: UILabel!
    @IBOutlet weak var rentHistoryView: UIView!
    @IBOutlet weak var BooksCollectionView: UICollectionView!
    
    private let viewModel = ProfileLenderViewModel()
    private let disposeBag = DisposeBag()
    private var lenderId: Int = 0
    private var userPenyewa: Bool = false
    
    func setLenderId(id: Int) {
        self.lenderId = id
    }
    
    func setUserPenyewa(flag: Bool) {
        self.userPenyewa = flag
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getLenderProfile(lenderId: lenderId)
        viewModel.getListBook(lenderId: lenderId, userPenyewa: userPenyewa)
        setView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BooksCollectionView.delegate = self
        setupRx()
    }
    
    func setView() {
        if !userPenyewa {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit Profile", style: .plain, target: self, action: #selector(editTapped))
            rentHistoryView.isHidden = false
        }
        else {
            rentHistoryView.isHidden = true
        }
        
    }
    
    private func setupRx() {
        
        //MARK: - Setup View Detail Toko
        viewModel.lenderProfile.subscribe (onNext: { response in
            if let image = response.images {
                if !image.isEmpty{
                    self.circleLenderImageView.setImage(fromUrl: Constant.Network.baseUrl + (image[0].url ?? ""))
                }else {
                    self.circleLenderImageView.setBackgroundColor(color: #colorLiteral(red: 0.9058823529, green: 0.9568627451, blue: 1, alpha: 1))
                    self.circleLenderImageView.setPlaceHolderImage(image: #imageLiteral(resourceName: "store"))
                }
            }else {
                self.circleLenderImageView.setBackgroundColor(color: #colorLiteral(red: 0.9058823529, green: 0.9568627451, blue: 1, alpha: 1))
                self.circleLenderImageView.setPlaceHolderImage(image: #imageLiteral(resourceName: "store"))
            }
        }).disposed(by: disposeBag)
        
        viewModel.lenderProfile.asObservable().map { response in
            response.name
        }.bind(to: lenderNameLabel.rx.text)
        .disposed(by: disposeBag)
        
        viewModel.lenderProfile.asObservable().map { response in
            response.bio ?? ""
        }.bind(to: lenderBioLabel.rx.text)
        .disposed(by: disposeBag)
        
        //MARK: Ini mapping lokasinya mau pake Kota aja ya?
        viewModel.lenderProfile.asObservable().map { response in
            response.kota
        }.bind(to: lenderLocationLabel.rx.text)
        .disposed(by: disposeBag)
        
        
        BooksCollectionView.register(UINib(nibName: XIBConstant.LenderKatalogCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: XIBConstant.LenderKatalogCollectionViewCell)
        
        viewModel.listBook.bind(to: BooksCollectionView.rx.items(cellIdentifier: XIBConstant.LenderKatalogCollectionViewCell, cellType: LenderKatalogCollectionViewCell.self)) {  (row,book,cell) in
            if row == 0 && self.userPenyewa == false{
                cell.rootView.isHidden = true
                cell.addView.isHidden = false
            }
            else {
                cell.rootView.isHidden = false
                cell.addView.isHidden = true
                
                if let image = book.images {
                    if !image.isEmpty {
                        cell.katalogBookImage.kf.setImage(with: URL(string: Constant.Network.baseUrl + (image[0].url ?? "")))
                    } else {
                        cell.katalogBookImage.image = UIImage(systemName: "book.fill")
                    }
                } else {
                    cell.katalogBookImage.image = UIImage(systemName: "book.fill")
                }
                cell.KatalogBookTitle.text = book.book?.title
                cell.katalogBookWriter.text = book.book?.author
                cell.katalogBookRentPrice.text = "\(book.price?.toRupiah() ?? "")/minggu"
            }
            
        }.disposed(by: disposeBag)
        
        
        BooksCollectionView.rx.modelSelected(LenderBook.self)
            .subscribe(onNext: { model in
                if model.price != 0 {
                    let vc = ModuleBuilder.shared.goToDetailBooksViewController()
                    vc.hidesBottomBarWhenPushed = true
                    vc.id = model.id ?? 0
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            })
            .disposed(by: disposeBag)
        
        BooksCollectionView.rx.itemSelected.subscribe(onNext: { index in
            if index.row == 0 && self.userPenyewa == false {
                let vc = ModuleBuilder.shared.goToInsertBookViewController()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            }
        })
        .disposed(by: disposeBag)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = BooksCollectionView.bounds.width
        
        let cellWidth = (width/2) - 27
        let cellHeight = (width/1.5)
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    @objc func editTapped(){
        let vc = ModuleBuilder.shared.goToEditProfileLenderViewController()
        vc.lenderId = self.lenderId
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func semuaGenrePressed(_ sender: UIButton) {
        print("Sort Disini")
    }
    
    @IBAction func kelolaPenyewaanGetTapped(_ sender: UITapGestureRecognizer) {
        print("Lender Id \(DataManager.shared.getLenderId())")
        let vc = ModuleBuilder.shared.goToTransactionViewController()
        vc.hidesBottomBarWhenPushed = true
        vc.setLenderID(id: DataManager.shared.getLenderId())
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
