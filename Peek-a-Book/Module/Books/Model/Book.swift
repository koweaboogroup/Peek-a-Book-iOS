//
//  Book.swift
//  Peek-a-Book
//
//  Created by Yossan Sandi Rahmadi on 31/07/21.
//

import Foundation

// MARK: - Book
struct Book: Codable {
    let id: Int?
    let bookTitle, bookISBN, bookWriter, bookSinopsis: String?
    let bookGenre: BookGenre?
    let lenderBook: Int?
    let publishedAt, createdAt, updatedAt: String?
    let bookImage: [BookImage]?
    
    enum CodingKeys: String, CodingKey {
        case id, bookTitle, bookISBN, bookWriter, bookSinopsis
        case bookGenre = "book_genre"
        case lenderBook = "lender_book"
        case publishedAt = "published_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case bookImage
    }
}

// MARK: - BookGenre
struct BookGenre: Codable {
    let id: Int?
    let bookGenreName, bookGenreDesc: String?
    let bookGenre: String?
    let publishedAt, createdAt, updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id, bookGenreName, bookGenreDesc, bookGenre
        case publishedAt = "published_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - BookImage
struct BookImage: Codable {
    let id: Int?
    let name, alternativeText, caption: String?
    let width, height: Int?
    let formats: Formats?
    let hash, ext, mime: String?
    let size: Double?
    let url: String?
    let previewURL: String?
    let provider: String?
    let providerMetadata: String?
    let createdAt, updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, alternativeText, caption, width, height, formats, hash, ext, mime, size, url
        case previewURL = "previewUrl"
        case provider
        case providerMetadata = "provider_metadata"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - Formats
struct Formats: Codable {
    let thumbnail: Thumbnail?
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    let name, hash, ext, mime: String?
    let width, height: Int?
    let size: Double?
    let path: String?
    let url: String?
}
