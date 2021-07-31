//
//  File.swift
//  Peek-a-Book
//
//  Created by Arif Rahman on 31/07/21.
//

import Foundation

class DataManager {
    
    static let shared = DataManager()
    
    ///TODO : INI BELUM SELESAI, HANYA DUMMY. DIKATAKAN SELESAI KETIKA RESPONSE SUDAH ADA
    func profile(name: String, alamat: String) {
        UserDefaults.standard.string(forKey: Constant.UserDefaultConstant.name)
        UserDefaults.standard.set(name, forKey: Constant.UserDefaultConstant.name)
        
        UserDefaults.standard.string(forKey: Constant.UserDefaultConstant.alamat)
        UserDefaults.standard.set(alamat, forKey: Constant.UserDefaultConstant.alamat)
    }

    ///TODO : INI BELUM SELESAI, HANYA DUMMY. DIKATAKAN SELESAI KETIKA RESPONSE SUDAH ADA
    func saveTemporaryItem(itemKeranjang: String, quantityKeranjang: Int) {
        UserDefaults.standard.string(forKey: Constant.UserDefaultConstant.itemKeranjang)
        UserDefaults.standard.set(itemKeranjang, forKey: Constant.UserDefaultConstant.itemKeranjang)

        UserDefaults.standard.integer(forKey: Constant.UserDefaultConstant.quantityItem)
        UserDefaults.standard.set(quantityKeranjang, forKey: Constant.UserDefaultConstant.quantityItem)
    }
}
