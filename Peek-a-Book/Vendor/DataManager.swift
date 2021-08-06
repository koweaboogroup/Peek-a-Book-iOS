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
    var cart = [Int]()
    
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
        ProfileService.getProfile { user in
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
