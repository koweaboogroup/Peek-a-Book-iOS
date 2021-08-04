//
//  NotificationTableViewCell.swift
//  Peek-a-Book
//
//  Created by Gede Wicaksana on 03/08/21.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {
    @IBOutlet weak var notificationImageView:UIImageView!
    @IBOutlet weak var notificationTimeLabel:UILabel!
    @IBOutlet weak var notificationTitleLabel:UILabel!
    @IBOutlet weak var notificationDescLabel:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
