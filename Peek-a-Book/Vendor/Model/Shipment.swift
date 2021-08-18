//
//  Shipment.swift
//  Peek-a-Book
//
//  Created by Annetta Carolina on 03/08/21.
//

import Foundation

enum Shipment: String {
    case selfPickup = "Self Pickup"
    case cod = "COD"
    case kurir = "Kurir"
    
    func getServerAttributeName() -> String {
        switch self {
        case .selfPickup:
            return "self_pickup"
        case .cod:
            return "cod"
        case .kurir:
            return "kurir"
        }
    }
}
