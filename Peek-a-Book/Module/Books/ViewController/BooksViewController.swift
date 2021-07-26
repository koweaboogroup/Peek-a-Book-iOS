//
//  BooksViewController.swift
//  Peek-a-Book
//
//  Created by Yossan Sandi Rahmadi on 26/07/21.
//

import UIKit

class BooksViewController: UIViewController, BooksBaseCoordinated {
    var coordinator: BooksBaseCoordinator?
    
    init(coordinator: BooksBaseCoordinator, nibName: String) {
        super.init(nibName: nibName, bundle: nil)
        self.coordinator = coordinator
        title = "Books"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}
