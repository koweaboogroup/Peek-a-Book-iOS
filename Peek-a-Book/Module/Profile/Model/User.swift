//
//  User.swift
//  Peek-a-Book
//
//  Created by Yossan Sandi Rahmadi on 04/08/21.
//

import Foundation

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

struct Role: Codable {
    var id: Int? = nil
    var name: String? = nil
    var description: String? = nil
    var type: String? = nil
}

struct Lender: Codable {
    let id: Int?
    let name, bio: String?
    let user: Int?
    let alamat, provinsi, kota, kelurahan: String?
    let kecamatan: String?
    let longtitude, latitude: Double?
    let publishedAt, createdAt, updatedAt: String?
    let image: [ImageObject]?

    enum CodingKeys: String, CodingKey {
        case id, name, bio, user, alamat, provinsi, kota, kelurahan, kecamatan, longtitude, latitude
        case publishedAt = "published_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case image
    }
}
