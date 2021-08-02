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
    
    var method: HTTPMethod {
        switch self {
        case .post: return .post
        }
    }
    
    var url: URL {
        return URL(string: Constant.Network.baseUrl + "/auth/local")!
    }
    
    func asURLRequest() throws -> URLRequest {
        var request = URLRequest(url: url)
        
        switch self {
        case let .post(bookRequest):
            request.httpBody = try JSONEncoder().encode(bookRequest)
        }
        
        request.headers.add(.contentType("application/json"))
        request.headers.add(.accept("application/json"))
        
        request.method = method
        
        return request
    }
}
