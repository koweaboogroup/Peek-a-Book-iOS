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
    
    public var response: BookResponse! {
        didSet {
//            self.rootView.layer.applyShadow(
//                color: .black,
//                alpha: 0.5,
//                x: 0,
//                y: 5,
//                blur: 10,
//                spread: 0
//            )
            self.lenderStoreImage.setImage(fromUrl: Constant.Network.baseUrl + (response.lender?.image?[0].url ?? ""))
            self.lenderStoreName.text = response.lender?.name
            if response.distance == 0 {
                self.lenderStoreLocation.text = response.lender?.kota
            }else{
                self.lenderStoreLocation.text = "\(response.lender?.kota ?? "") (\(response.distance)m)"
            }
            self.bookTitle.text = response.book?.title
            self.bookWriter.text = response.book?.author
            self.bookRentPrice.text = "\(response.price?.toRupiah() ?? "")/minggu"
            self.bookImage.kf.setImage(with: URL(string: Constant.Network.baseUrl + (response.images?[0].url ?? "")))
        }
    }
}
