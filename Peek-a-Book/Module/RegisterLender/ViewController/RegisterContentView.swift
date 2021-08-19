//
//  RegisterContentView.swift
//  Peek-a-Book
//
//  Created by Arif Rahman on 01/08/21.
//

import UIKit

@IBDesignable
class RegisterContentView: UIView {
    
    //MARK: - IBOutlet
    @IBOutlet weak var storeNameTextField: UITextField!
    @IBOutlet weak var storeBioTextField: UITextField!
    @IBOutlet weak var detailAddressLabel: UILabel!
    
    @IBOutlet var registerContentView: UIView!
    
    //MARK: - Variable
    
    private var viewModel: RegisterLenderViewModel?
    
    
    
    func initViewModel(viewModel: RegisterLenderViewModel) {
        self.viewModel = viewModel
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        registerContentView = loadViewFromNib(nibName: XIBConstant.RegisterContentView)
        registerContentView.frame = self.bounds
        
        
        
        self.addSubview(registerContentView)
    }
    
    
    @IBAction func buttonAlamatPressed(_ sender: UIButton) {
        viewModel?.detailAddressPressed.onNext(true)
    }
}
