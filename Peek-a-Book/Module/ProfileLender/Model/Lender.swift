//
//  Lender.swift
//  Peek-a-Book
//
//  Created by Arif Rahman on 06/08/21.
//

import Foundation
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
