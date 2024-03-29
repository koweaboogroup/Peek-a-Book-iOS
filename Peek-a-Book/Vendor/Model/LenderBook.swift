//
//  LenderBook.swift
//  Peek-a-Book
//
//  Created by Yossan Sandi Rahmadi on 31/07/21.
//

import Foundation

// MARK: - LenderBook
struct LenderBook: Codable {
    let id, price: Int?
    let bookCondition: BookCondition?
    let lender: Lender?
    let book: Book?
    let page: Int?
    let isAvailable: Bool?
    let language, publishedAt, createdAt, updatedAt: String?
    let images: [ImageObject]?
    var distance: Double = 0.0
    

    enum CodingKeys: String, CodingKey {
        case id, price
        case bookCondition = "book_condition"
        case lender, book, page, language, isAvailable
        case publishedAt = "published_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case images
    }
}

struct LenderBookRequest: Codable {
    let price: Int
    let bookCondition, lender, book: Int
    let page: Int
    let language: String

    enum CodingKeys: String, CodingKey {
        case price
        case bookCondition = "book_condition"
        case lender, book, page, language
    }
}

struct LenderBookWithLenderId: Codable {
    let id, price: Int?
    let bookCondition: Int?
    let lender: Int?
    let book: Int?
    let page: Int?
    let language, publishedAt, createdAt, updatedAt: String?
    let images: [ImageObject]?
    var distance: Double = 0.0
    

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
