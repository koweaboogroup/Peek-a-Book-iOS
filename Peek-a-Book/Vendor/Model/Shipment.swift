//
//  Shipment.swift
//  Peek-a-Book
//
//  Created by Annetta Carolina on 03/08/21.
//

import Foundation

enum Shipment: String {
    case selfPickup = "self_pickup"
    case cod = "cod"
    case kurir = "kurir"
    
    func getTitle() -> String {
        switch self {
        case .selfPickup:
            return "Self Pickup"
        case .cod:
            return "COD"
        case .kurir:
            return "Kurir"
        }
    }
}
