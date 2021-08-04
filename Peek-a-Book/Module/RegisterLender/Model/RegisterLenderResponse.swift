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
//    let image: []?
}
