//
//  File.swift
//  Peek-a-Book
//
//  Created by Arif Rahman on 31/07/21.
//

import Foundation

class DataManager {
    
    static let shared = DataManager()
    
    var user: User?
    
    func isLoggedIn() -> Bool {
        let jwt = "jwt"
        let jwtValue = UserDefaults.standard.string(forKey: jwt)
        
        return jwtValue != nil
    }
    
    func getUser() -> User {
        return user
    }
    
    func setUser(user: User) {
        self.user = user
    }

    ///TODO : INI BELUM SELESAI, HANYA DUMMY. DIKATAKAN SELESAI KETIKA RESPONSE SUDAH ADA
    func addItemToCart(itemKeranjang: String, quantityKeranjang: Int) {
        UserDefaults.standard.string(forKey: Constant.UserDefaultConstant.itemKeranjang)
        UserDefaults.standard.set(itemKeranjang, forKey: Constant.UserDefaultConstant.itemKeranjang)

        UserDefaults.standard.integer(forKey: Constant.UserDefaultConstant.quantityItem)
        UserDefaults.standard.set(quantityKeranjang, forKey: Constant.UserDefaultConstant.quantityItem)
    }
}
