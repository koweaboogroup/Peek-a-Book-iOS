//
//  RegisterLenderRequest.swift
//  Peek-a-Book
//
//  Created by Annetta Carolina on 02/08/21.
//

import Foundation

struct RegisterLenderRequest: Codable {
    let name, bio, user, alamat: String?
    let provinsi, kota, kelurahan, kecamatan: String?
    let longtitude, latitude: Float?
}
