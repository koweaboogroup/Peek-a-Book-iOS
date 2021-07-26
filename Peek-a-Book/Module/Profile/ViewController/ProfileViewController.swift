//
//  ProfileViewController.swift
//  Peek-a-Book
//
//  Created by Yossan Sandi Rahmadi on 26/07/21.
//

import UIKit

class ProfileViewController: UIViewController, ProfileBaseCoordinated {
    var coordinator: ProfileBaseCoordinator?
    
    init(coordinator: ProfileBaseCoordinator, nibName: String) {
        super.init(nibName: nibName, bundle: nil)
        self.coordinator = coordinator
        title = "Profile"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        
    }

}
