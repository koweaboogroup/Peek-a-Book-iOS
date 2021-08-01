//
//  RegisterLenderViewController.swift
//  Peek-a-Book
//
//  Created by Arif Rahman on 01/08/21.
//

import UIKit

class RegisterLenderViewController: UIViewController {

    @IBOutlet weak var circleImageView: CircleImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        // Do any additional setup after loading the view.
    }

    private func setupView(){
        circleImageView.setBackgroundColor(color: #colorLiteral(red: 0.9058823529, green: 0.9568627451, blue: 1, alpha: 1))
        circleImageView.setImage(image: #imageLiteral(resourceName: "bag-icon"))
    }
}
