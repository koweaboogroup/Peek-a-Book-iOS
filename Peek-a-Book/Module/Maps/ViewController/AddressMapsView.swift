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
    
    private var mapsViewModel : MapsViewModel?
    
    func initViewModel(_ mapsViewModel: MapsViewModel) {
        self.mapsViewModel = mapsViewModel
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
        addressMapView = loadViewFromNib(nibName: XIBConstant.AddressMapsView)
        addressMapView.frame = self.bounds
        buttonDone.cornerRadius(10)
        self.addSubview(addressMapView)
    }
    
    @IBAction func buttonDonePressed(_ sender: UIButton) {
        mapsViewModel?.buttonDonePressed.onNext(true)
    }
}
