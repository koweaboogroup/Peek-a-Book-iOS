//
//  Constant.swift
//  Peek-a-Book
//
//  Created by Yossan Sandi Rahmadi on 28/07/21.
//

import UIKit

struct Constant {
    struct Network {
        static let baseUrl = "http://api.peekabooks.my.id"
    }
    
    struct Color {
        static let primary1 = UIColor.init(named: "primary-1")
        static let primary2 = UIColor.init(named: "primary-2")
        static let primary3 = UIColor.init(named: "primary-3")
        static let primary4 = UIColor.init(named: "primary-4")
        static let primary5 = UIColor.init(named: "primary-5")
        static let primary6 = UIColor.init(named: "primary-6")
    }
    
    struct Ilustration {
        static let emptyNotif = UIImage(named: "empty-notif")
        static let emptyState = UIImage(named: "empty-state")
        static let login = UIImage(named: "login")
    }
    
    struct UserDefaultConstant {
        static let name = "name"
        static let alamat = "alamat"
        
        static let itemKeranjang = "item keranjang"
        static let quantityItem = "quantity keranjang"
    }
}
