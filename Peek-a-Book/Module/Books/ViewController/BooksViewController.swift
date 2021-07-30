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
        view.backgroundColor = .red
    }
    @IBAction func gotodetailbook(_ sender: UIButton) {
        let vc = DetailBooksViewController(
            nibName: "\(DetailBooksViewController.self)",
                bundle: nil)
        

        vc.hidesBottomBarWhenPushed = true
     //   self.present(vc, animated: true, completion: nil)
        
             navigationController?.pushViewController(vc,
                animated: true)
    }
}
