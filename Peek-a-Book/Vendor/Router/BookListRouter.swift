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
    
    var method: HTTPMethod {
        switch self {
        case .get: return .get
        }
    }
    
    var urlBooks: URL {
        return URL(string: Constant.Network.baseUrl + "/lender-books")!
    }
    
    func asURLRequest() throws -> URLRequest {
        var request = URLRequest(url: urlBooks)
        
        switch self {
        case .get:
            break
        }
        
        request.headers.add(.contentType("application/json"))
        request.headers.add(.accept("application/json"))
        
        request.method = method
        
        return request
    }
}

