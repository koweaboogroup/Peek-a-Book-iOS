//
//  CircleImageView.swift
//  Peek-a-Book
//
//  Created by Arif Rahman on 01/08/21.
//

import UIKit

@IBDesignable
class CircleImageView: UIImageView {
    
    
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var placeholderImage: UIImageView!
    @IBOutlet weak var circleImageView: UIView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        circleImageView = loadViewFromNib(nibName: XIBConstant.CircleImageView)
        circleImageView.frame = self.bounds
        circleImageView.layer.cornerRadius = circleImageView.frame.size.height/2
        placeImage.layer.cornerRadius = circleImageView.frame.size.height/2
        
        self.addSubview(circleImageView)
    }
    
    func setPlaceHolderImage(image: UIImage) {
        placeholderImage.image = image
        placeImage.isHidden = true
        placeholderImage.isHidden = false
    }
    
    func setImage(image: UIImage) {
        placeImage.image = image
        placeImage.isHidden = false
        placeholderImage.isHidden = true
    }
    
    func setBackgroundColor(color: UIColor) {
        circleImageView.backgroundColor = color
    }
}
