//
//  BookRouter.swift
//  Peek-a-Book
//
//  Created by Arif Rahman on 01/08/21.
//

import Foundation
import Alamofire

enum BookRouter: URLRequestConvertible {
    
    case get(id: String), getByTitle(title: String), addBook(bookRequest: [String: String])
    
    var method: HTTPMethod {
        switch self {
        case .get: return .get
        case .getByTitle: return .get
        case .addBook: return .post
        }
    }
    
    var url: URL {
        switch self {
        case .get(id: let id):
            return URL(string: Constant.Network.baseUrl + "/lender-books/\(id)")!
        case .getByTitle(title: let title):
            return URL(string: Constant.Network.baseUrl + "/books?title=\(title)")!
        case .addBook:
            return URL(string: Constant.Network.baseUrl + "/books")!
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        var request = URLRequest(url: url)
        request.headers.add(.contentType("application/json"))
        request.headers.add(.accept("application/json"))
        
        switch self {
        case .get:
            break
        case .getByTitle:
            break
        case .addBook(bookRequest: let bookRequest):
            request = try JSONParameterEncoder().encode(bookRequest, into: request)
        }
        
        if let jwt = UserDefaults.standard.string(forKey: "jwt"){
            request.headers.add(.authorization(bearerToken: jwt))
        }
        
        request.method = method
        
        return request
    }
    
}
