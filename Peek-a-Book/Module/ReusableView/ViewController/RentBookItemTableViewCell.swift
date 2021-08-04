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
}
