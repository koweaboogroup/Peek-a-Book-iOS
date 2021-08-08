//
//  BookRouter.swift
//  Peek-a-Book
//
//  Created by Arif Rahman on 01/08/21.
//

import Foundation
import Alamofire

enum BookRouter: URLRequestConvertible {
    
    case get(id: String)
    
    var method: HTTPMethod {
        switch self {
        case .get: return .get
        }
    }
    
    var url: URL {
        return URL(string: Constant.Network.baseUrl + "/lender-books/")!
    }
    
    func asURLRequest() throws -> URLRequest {
        var urlWithParams: URL

        switch self {
        case let .get(id):
            urlWithParams = url.appendingPathComponent(id)
        }
        
        var request = URLRequest(url: urlWithParams)
        request.headers.add(.contentType("application/json"))
        request.headers.add(.accept("application/json"))
        
        request.method = method
        
        return request
    }
}
