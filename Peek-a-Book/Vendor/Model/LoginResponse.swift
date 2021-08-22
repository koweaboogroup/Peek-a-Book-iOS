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
