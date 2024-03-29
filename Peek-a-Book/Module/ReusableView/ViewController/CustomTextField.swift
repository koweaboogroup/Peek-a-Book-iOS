//
//  CustomTextField.swift
//  Peek-a-Book
//
//  Created by Arif Rahman on 02/08/21.
//

import UIKit

@IBDesignable
class CustomTextField: UIView {
    
    @IBOutlet var textView: UIView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var fieldName: UITextField!
    @IBOutlet weak var chevronRight: UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        textView = loadViewFromNib(nibName: XIBConstant.CustomTextFieldView)
        textView.frame = self.bounds
        
        self.addSubview(textView)
    }
    
    func setTitleLabel(_ title: String) {
        labelTitle.text = title
    }
    
    func setPlaceholderField(_ title: String) {
        fieldName.placeholder = title
    }
    
    func showChevron(isShow: Bool) {
        chevronRight.isHidden = !isShow
        fieldName.isEnabled = !isShow
    }
    
    var text : String? {
        return fieldName.text
    }
    
    func isPassword(_ params: Bool) {
        if params {
            fieldName.isSecureTextEntry = true
        }else{
            fieldName.isSecureTextEntry = false
        }
    }
}
