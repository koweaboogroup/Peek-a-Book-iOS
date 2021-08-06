//
//  User.swift
//  Peek-a-Book
//
//  Created by Yossan Sandi Rahmadi on 04/08/21.
//

import Foundation

class User: Codable {
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
    var lender: Lender? = nil
}

struct Role: Codable {
    var id: Int? = nil
    var name: String? = nil
    var description: String? = nil
    var type: String? = nil
}
