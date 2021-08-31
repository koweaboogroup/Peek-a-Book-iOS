//
//  SearchViewController.swift
//  Peek-a-Book
//
//  Created by Arif Rahman on 24/08/21.
//

import UIKit
import RxSwift

class SearchViewController: UIViewController, UICollectionViewDelegateFlowLayout{

    @IBOutlet weak var searchView: SearchView!
    @IBOutlet weak var bookCollectionView: UICollectionView!
    @IBOutlet weak var emptyView: UIStackView!
    
    private let viewModel = BooksViewModel()
    private let disposeBag = DisposeBag()
    private var query = ""
    private var isFiction = true

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchBook()
        setupView()
        setupCellSelected()
        setupListener()
    }
    
    private func fetchBook(){
        viewModel.getListBook(query: query, isFiction: isFiction)
    }
    
    private func setupView(){
        bookCollectionView.delegate = self
        searchView.hideNotification(true)
        searchView.hideLocationLabel(true)
        searchView.searchField.text = query
        
        bookCollectionView.register(UINib(nibName: XIBConstant.BooksHomescreenCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: XIBConstant.BooksHomescreenCollectionViewCell)

        viewModel.listBook.asObserver().map { item in
            !item.isEmpty
        }.bind(to: emptyView.rx.isHidden)
        .disposed(by: disposeBag)
        
        viewModel.listBook.bind(to: bookCollectionView.rx.items(cellIdentifier: XIBConstant.BooksHomescreenCollectionViewCell, cellType: BooksHomescreenCollectionViewCell.self)){ (row,book,cell) in
            cell.response = book
        }.disposed(by: disposeBag)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = bookCollectionView.bounds.width
        
        let cellWidth = (width/2) - 27
        let cellHeight = (width/1.5)
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    private func setupCellSelected(){
        bookCollectionView.rx.modelSelected(LenderBook.self)
            .subscribe(onNext: { model in
                let vc = ModuleBuilder.shared.goToDetailBooksViewController()
                vc.hidesBottomBarWhenPushed = true
                vc.id = model.id ?? 0
                self.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func setupListener(){
        searchView.setNavigationController(vc: navigationController)
        searchView.searchField.addTarget(self, action: #selector(textFieldDidChange), for: .editingDidEndOnExit)
    }
    
    @objc func textFieldDidChange(){
        searchBook(query: searchView.searchField.text ?? "")
    }

    
    private func searchBook(query: String){
        viewModel.getListBook(query: query, isFiction: isFiction)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showNavigation(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        showNavigation(false)
    }
    
    func setQuery(query: String, isFiction: Bool = true) {
        self.query = query
        self.isFiction = isFiction
    }
}
