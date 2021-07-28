//
//  AlamatMaps.swift
//  Peek-a-Book
//
//  Created by Arif Rahman on 28/07/21.
//

import UIKit

@IBDesignable
class AddressMapsView: UIView {

    @IBOutlet weak var addressMapView: UIView!
    @IBOutlet weak var labelAlamat: UILabel!
    @IBOutlet weak var labelDetailAlamat: UILabel!
    @IBOutlet weak var buttonDone: UIButton!
    @IBOutlet weak var buttonSearch: UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        addressMapView = loadViewFromNib()
        addressMapView.frame = self.bounds
        self.addSubview(addressMapView)
    }
    
    func loadViewFromNib() -> UIView? {
        let nib = UINib(nibName: XIBConstant.AddressMapsView, bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}
