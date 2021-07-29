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
        
        mapsViewModel.streetName
            .subscribe(onNext: { test in
                print(test)
            })
            .disposed(by: disposeBag)
    }
    
    @IBAction func mapsDidTap(_ sender: UIButton) {
        let vc = MapsViewController(nibName: "MapsViewController", bundle: nil)
        vc.initViewModel(mapsViewModel)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
}
