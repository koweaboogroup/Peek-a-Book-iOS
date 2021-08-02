//
//  File.swift
//  Peek-a-Book
//
//  Created by Arif Rahman on 31/07/21.
//

import Foundation

class DataManager {
    
    static let shared = DataManager()
    
    func isLoggedIn() -> Bool {
        let jwt = "jwt"
        let jwtValue = UserDefaults.standard.string(forKey: jwt)
        
        return jwtValue != nil
    }
    
    func saveProfile(user: User) {
        do {
            let data = try JSONEncoder().encode(user)
            UserDefaults.standard.set(data, forKey: Constant.UserDefaultConstant.user)
        } catch {
            print("Unable to Encode Note (\(error))")
        }
    }

    ///TODO : INI BELUM SELESAI, HANYA DUMMY. DIKATAKAN SELESAI KETIKA RESPONSE SUDAH ADA
    func addItemToCart(itemKeranjang: String, quantityKeranjang: Int) {
        UserDefaults.standard.string(forKey: Constant.UserDefaultConstant.itemKeranjang)
        UserDefaults.standard.set(itemKeranjang, forKey: Constant.UserDefaultConstant.itemKeranjang)

        UserDefaults.standard.integer(forKey: Constant.UserDefaultConstant.quantityItem)
        UserDefaults.standard.set(quantityKeranjang, forKey: Constant.UserDefaultConstant.quantityItem)
    }
}
