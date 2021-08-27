//
//  BookListRouter.swift
//  Peek-a-Book
//
//  Created by Arif Rahman on 04/08/21.
//

import Foundation
import Alamofire

enum BookListRouter: URLRequestConvertible {
    
    case get
    case getSearch(query: String)
    
    var method: HTTPMethod {
        switch self {
        case .get: return .get
        case .getSearch: return .get
        }
    }
    
    var urlBooks: URL {
        switch self {
        case .get:
            return URL(string: Constant.Network.baseUrl + "/lender-books")!
        case .getSearch(let query):
            return URL(string: Constant.Network.baseUrl + "/lender-books?book.title_contains=\(query)")!
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        var request = URLRequest(url: urlBooks)
                
        request.headers.add(.contentType("application/json"))
        request.headers.add(.accept("application/json"))
        
        request.method = method
        
        return request
    }
}

