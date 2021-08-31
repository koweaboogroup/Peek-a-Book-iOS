//
//  BooksHomescreenCollectionViewCell.swift
//  Peek-a-Book
//
//  Created by Gede Wicaksana on 27/07/21.
//

import UIKit

class BooksHomescreenCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var rootView: UIView!
    @IBOutlet weak var lenderStoreName:UILabel!
    @IBOutlet weak var lenderStoreLocation:UILabel!
    @IBOutlet weak var lenderStoreImage:CircleImageView!
    @IBOutlet weak var bookImage:UIImageView!
    @IBOutlet weak var bookTitle:UILabel!
    @IBOutlet weak var bookWriter:UILabel!
    @IBOutlet weak var bookRentPrice:UILabel!
    
    override func awakeFromNib() {
        rootView.layer.applyShadow(
            color: .black,
            alpha: 0.1,
            x: 0,
            y: 6,
            blur: 30,
            spread: 0
        )
    }
    
    var response: LenderBook? {
        didSet {
            if let response = response {
                if let image = response.lender?.images {
                    if !image.isEmpty {
                        self.lenderStoreImage.setImage(fromUrl: Constant.Network.baseUrl + (image[0].url ?? ""))
                    }else{
                        self.lenderStoreImage.backgroundColor = #colorLiteral(red: 0.9058823529, green: 0.9568627451, blue: 1, alpha: 1)
                        self.lenderStoreImage.setPlaceHolderImage(image: UIImage(systemName: "person")!)
                    }
                }else{
                    self.lenderStoreImage.backgroundColor = #colorLiteral(red: 0.9058823529, green: 0.9568627451, blue: 1, alpha: 1)
                    self.lenderStoreImage.setPlaceHolderImage(image: UIImage(systemName: "person")!)
                }
                self.lenderStoreName.text = response.lender?.name
                if response.distance == 0 {
                    self.lenderStoreLocation.text = response.lender?.kota
                }else{
                    self.lenderStoreLocation.text = "\(response.lender?.kota ?? "") (\(response.distance)m)"
                }
                self.bookTitle.text = response.book?.title
                self.bookWriter.text = response.book?.author
                
                if response.isAvailable == false {
                    self.bookRentPrice.textColor = .lightGray
                    self.bookRentPrice.text = "Dalam Penyewaan"
                } else {
                    self.bookRentPrice.textColor = .black
                    self.bookRentPrice.text = "Rp\(response.price?.toRupiah() ?? "")/minggu"
                }
                
                if let image = response.images {
                    if !image.isEmpty {
                        self.bookImage.kf.setImage(with: URL(string: Constant.Network.baseUrl + (image[0].url ?? "")))
                    } else {
                        self.bookImage.image = UIImage(systemName: "book.fill")
                    }
                }else {
                    self.bookImage.image = UIImage(systemName: "book.fill")
                }
            }
        }
    }
}
