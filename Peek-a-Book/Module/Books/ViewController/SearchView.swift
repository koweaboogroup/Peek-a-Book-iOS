//
//  SearchView.swift
//  Peek-a-Book
//
//  Created by Arif Rahman on 30/07/21.
//

import UIKit

@IBDesignable
class SearchView: UIView {

    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var searchBar: UIView!
    @IBOutlet weak var buttonNotif: UIButton!
    @IBOutlet weak var labelLocation: UILabel!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var pinLocation: UIImageView!
    
    private var vc: UINavigationController?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit(){
        searchView = loadViewFromNib(nibName: XIBConstant.SearchView)
        searchView.frame = self.bounds
        searchView.backgroundColor = #colorLiteral(red: 0.8, green: 0.9098039216, blue: 1, alpha: 1)
        searchBar.cornerRadius(10)
        searchBar.layer.applyShadow(
            color: .black,
            alpha: 0.2,
            x: 0,
            y: 3,
            blur: 10,
            spread: 0
        )
        self.addSubview(searchView)
    }
    
    func hideNavigation(_ isHide: Bool) {
        buttonBack.isHidden = isHide
    }

    func hideNotification(_ isHide: Bool) {
        buttonNotif.isHidden = isHide
    }
    
    func hideLocationLabel(_ isHide: Bool) {
        labelLocation.isHidden = isHide
        pinLocation.isHidden = isHide
    }
    
    func setNavigationController(vc: UINavigationController?) {
        self.vc = vc
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        vc?.popViewController(animated: true)
    }
    
}
