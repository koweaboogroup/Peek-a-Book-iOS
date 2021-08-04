//
//  RegisterRequest.swift
//  Peek-a-Book
//
//  Created by Annetta Carolina on 02/08/21.
//

import Foundation

struct RegisterRequest: Codable {
    var username, email, password, phoneNumber: String
    var alamat, provinsi, kota, kelurahan, kecamatan: String
    var longtitude, latitude: Float
}
