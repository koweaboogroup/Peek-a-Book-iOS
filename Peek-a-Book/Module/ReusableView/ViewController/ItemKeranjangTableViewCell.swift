//
//  ItemKeranjangTableViewCell.swift
//  Peek-a-Book
//
//  Created by Gede Wicaksana on 02/08/21.
//

import UIKit

class ItemKeranjangTableViewCell: UITableViewCell {
    @IBOutlet weak var BookImage:UIImageView!
    @IBOutlet weak var BookTitle:UILabel!
    @IBOutlet weak var BookWriter:UILabel!
    
    
    public var response: LenderBook! {
        didSet {
//            self.rootView.layer.applyShadow(
//                color: .black,
//                alpha: 0.5,
//                x: 0,
//                y: 5,
//                blur: 10,
//                spread: 0
//            )
//            self.BookImage.setImage(fromUrl: Constant.Network.baseUrl + (response.lender?.image?[0].url ?? ""))
//            self.BookTitle.text = response.lender?.
//            if response.distance == 0 {
//                self.lenderStoreLocation.text = response.lender?.kota
//            }else{
//                self.lenderStoreLocation.text = "\(response.lender?.kota ?? "") (\(response.distance)m)"
//            }
//            self.bookTitle.text = response.book?.title
//            self.bookWriter.text = response.book?.author
//            self.bookRentPrice.text = "\(response.price?.toRupiah() ?? "")/minggu"
//            self.bookImage.kf.setImage(with: URL(string: Constant.Network.baseUrl + (response.images?[0].url ?? "")))
        }
    }
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
