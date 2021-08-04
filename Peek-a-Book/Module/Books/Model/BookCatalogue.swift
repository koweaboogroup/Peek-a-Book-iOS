//
//  BookCatalogue.swift
//  Peek-a-Book
//
//  Created by Yossan Sandi Rahmadi on 05/08/21.
//

import Foundation

// MARK: - BookCatalogueElement
struct BookCatalogueElement: Codable {
    let id, price: Int?
    let bookCondition: BookCondition?
    let lender: Lender?
    let book: Book?
    let page: Int?
    let language, publishedAt, createdAt, updatedAt: String?
    let images: [Image]?

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
struct Image: Codable {
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

typealias BookCatalogue = [BookCatalogueElement]

