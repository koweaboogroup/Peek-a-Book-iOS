//
//  RentRequest.swift
//  Peek-a-Book
//
//  Created by Yossan Sandi Rahmadi on 16/08/21.
//

import Foundation

struct RentRequest: Codable {
    let periodOfTime: Int
    let user: Int
    let shippingMethods, status, alamat: String
    let provinsi, kota, kelurahan, kecamatan: String
    let longtitude, latitude: Int
    let lenderBooks: [LenderBook]
    
    enum CodingKeys: String, CodingKey {
        case periodOfTime, shippingMethods, status, user, alamat, provinsi, kota, kelurahan, kecamatan, longtitude, latitude
        case lenderBooks = "lender_books"
    }
}


