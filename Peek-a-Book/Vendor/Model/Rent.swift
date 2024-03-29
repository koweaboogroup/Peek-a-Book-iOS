//
//  Rent.swift
//  Peek-a-Book
//
//  Created by Muhammad Rifki Widadi on 04/08/21.
//

import Foundation

struct Rent: Codable {
    let id, periodOfTime: Int?
    let shippingMethods: String?
    let status: Status?
    let user: User?
    let alamat, provinsi, kota, kelurahan: String?
    let kecamatan: String?
    let longtitude, latitude: Double?
    let publishedAt, createdAt, updatedAt: String?
    let lenderBooks: [LenderBook]?
    let name, bio: String?
    var isFromRenter: Bool = true

    enum CodingKeys: String, CodingKey {
        case id, periodOfTime, shippingMethods, status, user, alamat, provinsi, kota, kelurahan, kecamatan, longtitude, latitude
        case publishedAt = "published_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case lenderBooks = "lender_books"
        case name, bio
    }
}

struct RentPostResponse: Codable {
    let id, periodOfTime: Int?
    let shippingMethods: String?
    let status: Status?
    let user: UserWithLenderId?
    let alamat, provinsi, kota, kelurahan: String?
    let kecamatan: String?
    let longtitude, latitude: Double?
    let publishedAt, createdAt, updatedAt: String?
    let lenderBooks: [LenderBookWithLenderId]?
    let name, bio: String?
    var isFromRenter: Bool = true

    enum CodingKeys: String, CodingKey {
        case id, periodOfTime, shippingMethods, status, user, alamat, provinsi, kota, kelurahan, kecamatan, longtitude, latitude
        case publishedAt = "published_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case lenderBooks = "lender_books"
        case name, bio
    }
}


struct Status: Codable {
    let id: Int
    let name, statusDescription, publishedAt, createdAt: String
    let updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case statusDescription = "description"
        case publishedAt = "published_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
