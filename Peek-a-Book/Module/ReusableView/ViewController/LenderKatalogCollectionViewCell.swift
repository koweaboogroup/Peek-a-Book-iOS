//
//  LenderKatalogCollectionViewCell.swift
//  Peek-a-Book
//
//  Created by Gede Wicaksana on 25/08/21.
//

import UIKit

class LenderKatalogCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var addView: UIView!
    @IBOutlet weak var rootView: UIView!
    @IBOutlet weak var katalogBookImage:UIImageView!
    @IBOutlet weak var KatalogBookTitle:UILabel!
    @IBOutlet weak var katalogBookWriter:UILabel!
    @IBOutlet weak var katalogBookRentPrice:UILabel!
    override func awakeFromNib() {
        addView.layer.applyShadow(
            color: .black,
            alpha: 0.1,
            x: 0,
            y: 6,
            blur: 30,
            spread: 0
        )
        rootView.layer.applyShadow(
            color: .black,
            alpha: 0.1,
            x: 0,
            y: 6,
            blur: 30,
            spread: 0
        )
    }
//    var response: LenderBook? {
//        didSet {
//            if let response = response {
//                self.KatalogBookTitle.text = response.book?.title
//                self.katalogBookWriter.text = response.book?.author
//                self.katalogBookRentPrice.text = "\(response.price?.toRupiah() ?? "")/minggu"
//                if let image = response.images {
//                    if !image.isEmpty {
//                        self.katalogBookImage.kf.setImage(with: URL(string: Constant.Network.baseUrl + (image[0].url ?? "")))
//                    } else {
//                        self.katalogBookImage.image = UIImage(systemName: "book.fill")
//                    }
//                }else {
//                    self.katalogBookImage.image = UIImage(systemName: "book.fill")
//                }
//            }
//        }
//    }
}
