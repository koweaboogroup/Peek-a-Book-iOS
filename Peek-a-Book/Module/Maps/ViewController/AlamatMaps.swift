//
//  AlamatMaps.swift
//  Peek-a-Book
//
//  Created by Arif Rahman on 28/07/21.
//

import UIKit

@IBDesignable
class AlamatMaps: UIView {

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
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    func loadViewFromNib() -> UIView? {
        let nib = UINib(nibName: XIBConstant.AlamatMapsView, bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}
