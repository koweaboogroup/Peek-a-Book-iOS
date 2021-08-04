//
//  RegisterResponse.swift
//  Peek-a-Book
//
//  Created by Annetta Carolina on 02/08/21.
//

import Foundation

struct RegisterResponse: Codable {
    var jwt: String? = nil
    var user: User? = nil
}
