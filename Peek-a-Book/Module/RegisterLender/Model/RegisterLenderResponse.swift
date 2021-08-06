//
//  RegisterLenderResponse.swift
//  Peek-a-Book
//
//  Created by Annetta Carolina on 02/08/21.
//

import Foundation

struct RegisterLenderResponse: Codable {
    let id: Int?
    let name, bio: String?
    let user: User?
    let alamat, provinsi, kota, kelurahan: String?
    let kecamatan: String?
    let longtitude, latitude: Float?
    let publishedAt, createdAt, updatedAt: String?
    let image: [ImageObject]?
    
    enum CodingKeys: String, CodingKey {
            case id, name, bio, user, alamat, provinsi, kota, kelurahan, kecamatan, longtitude, latitude, image
            case publishedAt = "published_at"
            case createdAt = "created_at"
            case updatedAt = "updated_at"
//            case image
        }
}
