//
//  BookRouter.swift
//  Peek-a-Book
//
//  Created by Arif Rahman on 01/08/21.
//

import Foundation
import Alamofire

enum BookRouter: URLRequestConvertible {
    
    ///TODO : UBAH REQUEST DAN RESPONSE
    case post(BookRequest)
    case get
    
    var method: HTTPMethod {
        switch self {
        case .post: return .post
        case .get: return .get
        }
    }
    
    var url: URL {
        return URL(string: Constant.Network.baseUrl + "/auth/local")!
    }
    var urlBooks: URL {
        return URL(string: Constant.Network.baseUrl + "/lender-books")!
    }
    
    func asURLRequest() throws -> URLRequest {
        var request = URLRequest(url: url)
        
        switch self {
        case let .post(bookRequest):
            request.httpBody = try JSONEncoder().encode(bookRequest)
        case .get: break

        }
        
        request.headers.add(.contentType("application/json"))
        request.headers.add(.accept("application/json"))
        
        request.method = method
        
        return request
    }
}
