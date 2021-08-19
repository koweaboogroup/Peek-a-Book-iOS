//
//  File.swift
//  Peek-a-Book
//
//  Created by Arif Rahman on 31/07/21.
//

import Foundation
import RxSwift

class DataManager {
    
    static let shared = DataManager()
    let isUserFetched: PublishSubject<Bool> = PublishSubject()
    
    private var user: User?
    var lender: Lender?
    
    // MARK: Cart is array of lenderBookId
    private var cart = [LenderBook]()
    
    func isLoggedIn() -> Bool {
        let jwt = "jwt"
        let jwtValue = UserDefaults.standard.string(forKey: jwt)
        
        return jwtValue != nil
    }
    
    func getUserIdByJwt() -> Int {
        let jwtKey = "jwt"

        if let jwt = UserDefaults.standard.string(forKey: jwtKey) {
            if let decodedJwt = try? decode(jwtToken: jwt) {
                return decodedJwt["id"] as! Int
            }
        }
        
        return -1
    }
    
    func fetchUser() {
        self.isUserFetched.onNext(false)
        ProfileService.getProfile(userId: user?.id ?? -1) { user in
            self.user = user
            self.isUserFetched.onNext(true)
        } failCompletion: { error in
            print(error)
        }

    }
    
    func getUser() -> User? {
        return user
    }
    
    func setUser(user: User) {
        self.user = user
    }
    
    func getLenderId() -> Int {
        lender?.id ?? -1
    }

    func addItemToCart(lenderBook: LenderBook) {
        cart.append(lenderBook)
    }
    
    func deleteCart() {
        cart = []
    }
    
    func saveCartToUserDefaults() {
        let cartKey = "cart"
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(cart){
            UserDefaults.standard.set(encoded, forKey: cartKey)
        }
    }
    
    func loadCartFromUserDefaults() {
        let cartKey = "cart"
        
        if let data = UserDefaults.standard.data(forKey: cartKey) {
    
            // Create JSON Decoder
            let decoder = JSONDecoder()

            // Decode Note
            let lenderBook = try? decoder.decode([LenderBook].self, from: data)
            
            self.cart = lenderBook ?? []
        }
    }
    
    func getCart() -> [LenderBook] {
        return cart
    }
    
    private func decode(jwtToken jwt: String) throws -> [String: Any] {
        
        enum DecodeErrors: Error {
            case badToken
            case other
        }

        func base64Decode(_ base64: String) throws -> Data {
            let padded = base64.padding(toLength: ((base64.count + 3) / 4) * 4, withPad: "=", startingAt: 0)
            guard let decoded = Data(base64Encoded: padded) else {
                throw DecodeErrors.badToken
            }
            return decoded
        }

        func decodeJWTPart(_ value: String) throws -> [String: Any] {
            let bodyData = try base64Decode(value)
            let json = try JSONSerialization.jsonObject(with: bodyData, options: [])
            guard let payload = json as? [String: Any] else {
                throw DecodeErrors.other
            }
            return payload
        }

        let segments = jwt.components(separatedBy: ".")
        return try decodeJWTPart(segments[1])
      }
}
