//
//  ErrorStateView.swift
//  Peek-a-Book
//
//  Created by Muhammad Rifki Wildadi on 26/08/21.
//

import UIKit

@IBDesignable
class ErrorStateView: UIView {
    @IBOutlet weak var errorImage: UIImageView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var errorStateView: UIView!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func setError(errorMessage: String) {
        errorLabel.text = errorMessage
    }
    
    func commonInit() {
        errorStateView = loadViewFromNib(nibName: XIBConstant.ErrorStateView)
        errorStateView.frame = self.bounds
        
        self.addSubview(errorStateView)
    }
    
}
