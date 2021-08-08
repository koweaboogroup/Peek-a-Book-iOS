//
//  LoginRouter.swift
//  Peek-a-Book
//
//  Created by Annetta Carolina on 30/07/21.
//

import Alamofire

enum LoginRouter: URLRequestConvertible {
    
    case post(LoginRequest)
    
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
        case let .post(loginRequest):
            request.httpBody = try JSONEncoder().encode(loginRequest)
        }
        
        request.headers.add(.contentType("application/json"))
        request.headers.add(.accept("application/json"))
        
        request.method = method
        
        return request
    }
}


