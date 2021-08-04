//
//  Order.swift
//  Peek-a-Book
//
//  Created by Yossan Sandi Rahmadi on 05/08/21.
//

import Foundation

// MARK: - Order
struct Order: Codable {
    let id, periodOfTime: Int?
    let shippingMethods: String?
    let timeStamp: Int?
    let status: String?
    let user: User?
    let address, alamat, provinsi, kota: String?
    let kelurahan, kecamatan, longtitude, latitude: String?
    let publishedAt, createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, periodOfTime, shippingMethods, timeStamp, status, address, alamat, provinsi, kota, kelurahan, kecamatan, longtitude, latitude
        
        // MARK: Sementara aku kasih coding keys, karena dari server mintanya users
        case user = "users"
        case publishedAt = "published_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
