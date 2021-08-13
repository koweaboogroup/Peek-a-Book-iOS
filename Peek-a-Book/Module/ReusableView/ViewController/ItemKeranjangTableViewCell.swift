//
//  ItemKeranjangTableViewCell.swift
//  Peek-a-Book
//
//  Created by Gede Wicaksana on 02/08/21.
//

import UIKit

class ItemKeranjangTableViewCell: UITableViewCell {
    @IBOutlet weak var bookImage:UIImageView!
    @IBOutlet weak var bookTitle:UILabel!
    @IBOutlet weak var bookWriter:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public var response: LenderBook? {
        didSet {
            if let response = response {
                self.bookImage.kf.setImage(with: URL(string: Constant.Network.baseUrl + (response.images?[0].url ?? "")))
                self.bookTitle.text = response.book?.title
                self.bookWriter.text = response.book?.author
            }
        }
    }
}
