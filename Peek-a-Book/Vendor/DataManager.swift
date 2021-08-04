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
    
    // MARK: Cart is array of lenderBookId
    var cart = [Int]()
    
    func isLoggedIn() -> Bool {
        let jwt = "jwt"
        let jwtValue = UserDefaults.standard.string(forKey: jwt)
        
        return jwtValue != nil
    }
    
    func getUser() -> User? {
        return user
    }
    
    func setUser(user: User) {
        self.user = user
    }

    func addItemToCart(lenderBookId: Int) {
        cart.append(lenderBookId)
    }
    
    func saveCartToUserDefaults() {
        let cartKey = "cart"
        UserDefaults.standard.set(cart, forKey: cartKey)
    }
    
    func loadCartFromUserDefaults() {
        let cartKey = "cart"
        cart = UserDefaults.standard.array(forKey: cartKey) as? [Int] ?? []
    }
}
