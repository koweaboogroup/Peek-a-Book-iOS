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
    var lender: Lender?
    
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
    
    func getUser() -> User? {
        return user
    }
    
    func getLenderId() -> Int {
        lender?.id ?? -1
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
