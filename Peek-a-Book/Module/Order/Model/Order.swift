//
//  Order.swift
//  Peek-a-Book
//
//  Created by Yossan Sandi Rahmadi on 05/08/21.
//

import Foundation

// MARK: - Order
struct Order: Codable {
    let id: Int?
    let rent: RentResponse?
    let publishedAt, createdAt, updatedAt: String?
    let lenderBooks: [LenderBook]?

    enum CodingKeys: String, CodingKey {
        case id, rent
        case publishedAt = "published_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case lenderBooks = "lender_books"
    }
}
