//
//  Book.swift
//  Peek-a-Book
//
//  Created by Yossan Sandi Rahmadi on 31/07/21.
//

import Foundation

// MARK: - Book
struct BookResponse: Codable {
    let id, price: Int?
    let bookCondition: BookCondition?
    let lender: LenderBook?
    let book: Book?
    let page: Int?
    let language, publishedAt, createdAt, updatedAt: String?
    let images: [ImageObject]?

    enum CodingKeys: String, CodingKey {
        case id, price
        case bookCondition = "book_condition"
        case lender, book, page, language
        case publishedAt = "published_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case images
    }
}

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

// MARK: - BookCondition
struct BookCondition: Codable {
    let id: Int?
    let title, bookConditionDescription, publishedAt, createdAt: String?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, title
        case bookConditionDescription = "description"
        case publishedAt = "published_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - Image
struct ImageObject: Codable {
    let id: Int?
    let name, alternativeText, caption: String?
    let width, height: Int?
    let formats: Formats?
    let hash, ext, mime: String?
    let size: Double?
    let url: String?
    let previewURL: String?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, name, alternativeText, caption, width, height, formats, hash, ext, mime, size, url
        case previewURL = "previewUrl"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}



// MARK: - Formats
struct Formats: Codable {
    let thumbnail, large, medium, small: Large?
}

// MARK: - Large
struct Large: Codable {
    let name, hash, ext, mime: String?
    let width, height: Int?
    let size: Double?
    let url: String?
}

// MARK: - Lender
struct LenderBook: Codable {
    let id: Int?
    let name, bio: String?
    let user: Int?
    let alamat, provinsi, kota, kelurahan: String?
    let kecamatan: String?
    let longtitude, latitude: Double?
    let publishedAt, createdAt, updatedAt: String?
    let image: [ImageObject]?

    enum CodingKeys: String, CodingKey {
        case id, name, bio, user, alamat, provinsi, kota, kelurahan, kecamatan, longtitude, latitude
        case publishedAt = "published_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case image
    }
}
