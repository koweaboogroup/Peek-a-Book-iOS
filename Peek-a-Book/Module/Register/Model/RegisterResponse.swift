//
//  RegisterResponse.swift
//  Peek-a-Book
//
//  Created by Annetta Carolina on 02/08/21.
//

import Foundation

struct RegisterResponse: Codable {
    var id: String? = nil
    var username: String? = nil
    var email: String? = nil
    var provider: String? = nil
    var confirmed: Bool? = nil
    var blocked: Bool? = nil
    
    //keyword 'Role' udah kepake, diganti apa ya?
    var role: Role? = nil
    var address: Address? = nil
}

//keyword 'Role' udah kepake, diganti apa ya?
struct Role: Codable {
    var id: String? = nil
    var name: String? = nil
    var description: String? = nil
    var type: String? = nil
    var permissions: [String]? = nil
    var users: [String]? = nil
    var created_by: String? = nil
    var updated_by: String? = nil
    
}

struct Address: Codable {
    var id: String? = nil
    var kecamatan: String? = nil
    var kelurahan: String? = nil
    var kota: String? = nil
    var provinsi: String? = nil
    var alamat: String? = nil
    
    //Ini bener pake Int kah?
    var longitude: Int? = nil
    var latitude: Int? = nil
    
    var user: String? = nil
    var rent: String? = nil
    var lender: String? = nil
    
    var published_at: String? = nil
    var created_by: String? = nil
    var updated_by: String? = nil
    
    
    
}
