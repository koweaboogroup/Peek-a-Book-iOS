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
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var buttonNotif: UIButton!
    @IBOutlet weak var labelLokasi: UILabel!
    @IBOutlet weak var searchView: UIView!
    
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
        searchView.cornerRadiusBottom(50)
        searchView.backgroundColor = #colorLiteral(red: 0.8, green: 0.9098039216, blue: 1, alpha: 1)
        self.addSubview(searchView)
    }

}
