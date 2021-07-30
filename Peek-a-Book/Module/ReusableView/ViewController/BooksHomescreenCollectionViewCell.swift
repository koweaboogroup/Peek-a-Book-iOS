//
//  BooksHomescreenCollectionViewCell.swift
//  Peek-a-Book
//
//  Created by Gede Wicaksana on 27/07/21.
//

import UIKit

class BooksHomescreenCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var lenderStoreName:UILabel!
    @IBOutlet weak var lenderStoreLocation:UILabel!
    @IBOutlet weak var lenderStoreImage:UIImageView!
    @IBOutlet weak var bookImage:UIImageView!
    @IBOutlet weak var bookTitle:UILabel!
    @IBOutlet weak var bookWriter:UILabel!
    @IBOutlet weak var bookRentPrice:UILabel!
}
