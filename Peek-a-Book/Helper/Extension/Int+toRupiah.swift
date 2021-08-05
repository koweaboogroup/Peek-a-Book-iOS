//
//  String+toRupiah.swift
//  Peek-a-Book
//
//  Created by Arif Rahman on 04/08/21.
//

import Foundation
extension Int {
    func toRupiah() -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "id_ID")
        formatter.groupingSeparator = "."
        formatter.numberStyle = .decimal
        return formatter.string(from: self as NSNumber) ?? String(self)
    }
}
