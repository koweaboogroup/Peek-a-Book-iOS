//
//  rentStatus.swift
//  Peek-a-Book
//
//  Created by Annetta Carolina on 03/08/21.
//

import Foundation

enum RentStatus: String {
    case allStatus = "Semua Status"
    case awaiting = "Dalam Proses"
    case shipping = "Dalam Pengiriman"
    case ongoing = "Sedang Berjalan"
    case returning = "Sedang Dikembalikan"
    case done = "Selesai"
    
    
    func getID() -> Int {
        
        switch self {
        case .allStatus:
            return 0
        case .awaiting:
            return 1
        case .shipping:
            return 2
        case .ongoing:
            return 3
        case .returning:
            return 4
        case .done:
            return 5
        }
        
    }
}
