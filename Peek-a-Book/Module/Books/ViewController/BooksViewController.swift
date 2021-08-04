//
//  BooksViewController.swift
//  Peek-a-Book
//
//  Created by Yossan Sandi Rahmadi on 26/07/21.
//

import UIKit
import RxSwift

class BooksViewController: UIViewController {
    let mapsViewModel = MapsViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let viewModel = BooksViewModel()
        viewModel.getListBook()
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    
    
    @IBAction func justfortest(_ sender: UIButton) {
        let vc = DetailBooksViewController(
            nibName: "\(DetailBooksViewController.self)",
                bundle: nil)
        vc.hidesBottomBarWhenPushed = true
             navigationController?.pushViewController(vc,
                animated: true)
    }
    
    
}
