//
//  RegisterContentView.swift
//  Peek-a-Book
//
//  Created by Arif Rahman on 01/08/21.
//

import UIKit

@IBDesignable
class RegisterContentView: UIView {
    
    @IBOutlet var registerContentView: UIView!
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
}