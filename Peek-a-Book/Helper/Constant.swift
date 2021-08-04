//
//  Constant.swift
//  Peek-a-Book
//
//  Created by Yossan Sandi Rahmadi on 28/07/21.
//

import UIKit

struct Constant {
    
    static let termsAndConditionsLink = "https://github.com/yrojx"
    
    struct Network {
        static let baseUrl = "http://103.214.112.183:1340"
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
        static let user = "user"
        
        static let itemKeranjang = "item keranjang"
        static let quantityItem = "quantity keranjang"
    }
}
