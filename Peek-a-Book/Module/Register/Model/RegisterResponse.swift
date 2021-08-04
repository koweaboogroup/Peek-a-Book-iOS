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

struct User: Codable {
    var id: Int? = nil
    var username: String? = nil
    var email: String? = nil
    var phoneNumber: String? = nil
    var alamat: String? = nil
    var provinsi: String? = nil
    var kota: String? = nil
    var kelurahan: String? = nil
    var kecamatan: String? = nil
    var longtitude: Float? = nil
    var latitude: Float? = nil
    var created_at: String? = nil
    var updated_at: String? = nil
}
