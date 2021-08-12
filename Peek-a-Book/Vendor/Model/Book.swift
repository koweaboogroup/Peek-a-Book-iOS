//
//  Book.swift
//  Peek-a-Book
//
//  Created by Yossan Sandi Rahmadi on 05/08/21.
//

import Foundation

// MARK: - Book
struct Book: Codable {
    let id: Int?
    let title, isbn, author, sinopsis: String?
    let bookGenre: Int?
    let isChecked: Bool?
    let publishedAt, createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, title, isbn, author, sinopsis
        case bookGenre = "book_genre"
        case isChecked
        case publishedAt = "published_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
