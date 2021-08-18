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
    case unfinish = "Tidak Selesai"
    
    func getID() -> Int {
        
        switch self {
        case .allStatus:
            return 2
        case .awaiting:
            return 3
        case .shipping:
            return 4
        case .ongoing:
            return 5
        case .returning:
            return 6
        case .done:
            return 7
        case .unfinish:
            return 8
        }
        
    }
}
