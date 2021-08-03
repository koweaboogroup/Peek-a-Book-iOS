//
//  RegisterRequest.swift
//  Peek-a-Book
//
//  Created by Annetta Carolina on 02/08/21.
//

import Foundation

struct RegisterRequest: Codable {
    var username, email, provider, password: String
    var resetPasswordToken, confirmationToken: String
    var confirmed, blocked: Bool
    var role, lender: String
    var rents: [String]
    var address: String
    var created_by, updated_by: String
}
