//
//  LoginResponse.swift
//  Peek-a-Book
//
//  Created by Annetta Carolina on 29/07/21.
//

import Foundation

struct LoginResponse: Codable {
    var jwt: String? = nil
    var user: User? = nil
}

//struct User: Codable {
//    var id: Int? = nil
//    var username: String? = nil
//    var email: String? = nil
//    var provider: String? = nil
//    var confirmed: Bool? = nil
//    var blocked: Bool? = nil
//    var role: Role? = nil
//    var userPhoneNumber: String? = nil
//    var userAddress: String? = nil
//    var lender: Lender? = nil
//    var created_at: String? = nil
//    var updated_at: String? = nil
////    var rents: []
//}

//struct Role: Codable {
//    var id: Int? = nil
//    var name: String? = nil
//    var description: String? = nil
//    var type: String? = nil
//}

struct Lender: Codable {
    var id: Int? = nil
    var lenderName: String? = nil
    var lenderBio: String? = nil
    var user: Int? = nil
    var published_at: String? = nil
    var created_at: String? = nil
    var updated_at: String? = nil
}
