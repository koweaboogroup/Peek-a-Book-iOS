//
//  RentBookItemView.swift
//  Peek-a-Book
//
//  Created by Muhammad Rifki Wildadi on 04/08/21.
//

import UIKit

class RentBookItemTableViewCell: UITableViewCell{
    
    @IBOutlet weak var imageProfileLenders: CircleImageView!
    @IBOutlet weak var lendersName: UILabel!
    @IBOutlet weak var statusRent: UILabel!
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookItemMoreThanOne: UILabel!
    @IBOutlet weak var rentDuration: UIButton!
    @IBOutlet weak var rentPrice: UILabel!
    
    @IBOutlet weak var warningButton: UIButton!
    @IBOutlet weak var activeButton: UIButton!
    
    var response : Rent? {
        didSet {
            if let response = response {
                let lenderImage = Constant.Network.baseUrl + (response.lenderBooks?[0].lender?.images?[0].url ?? "")
                let sampleLenderBookImage = Constant.Network.baseUrl + (response.lenderBooks?[0].images?[0].url ?? "")
                let countBooks = response.lenderBooks?.count ?? 0
                var price = 0
                
                lendersName.text = response.lenderBooks?[0].lender?.name
                bookTitle.text = response.lenderBooks?[0].book?.title
                if countBooks > 1 {
                    bookItemMoreThanOne.isHidden = false
                }else{
                    bookItemMoreThanOne.isHidden = true
                }
                
                bookItemMoreThanOne.text = "+\(countBooks - 1) buku lainnya"
                imageProfileLenders.setImage(fromUrl: lenderImage)
                bookImage.kf.setImage(with: URL(string: sampleLenderBookImage))
                rentDuration.setTitle("\(response.periodOfTime ?? 0) Minggu", for: .normal)
                
                if let books = response.lenderBooks {
                    for item in books {
                        price += (item.price ?? 0)
                    }
                }
                
                rentPrice.text = "Rp \(price.toRupiah())"
                statusRent.text = response.status?.name
            }
        }
    }
}
