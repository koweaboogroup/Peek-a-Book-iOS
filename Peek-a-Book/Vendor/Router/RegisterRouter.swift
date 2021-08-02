//
//  RegisterRouter.swift
//  Peek-a-Book
//
//  Created by Annetta Carolina on 30/07/21.
//

import Alamofire

enum RegisterRouter: URLRequestConvertible {

    case post(RegisterRequest)
    
    var method: HTTPMethod {
        switch self {
        case .post: return .post
        }
    }
    
    var url: URL {                                     //ganti link
        return URL(string: Constant.Network.baseUrl + "/auth/local")!
    }
    
    func asURLRequest() throws -> URLRequest {
        var request = URLRequest(url: url)
        
        switch self {
        case let .post(registerRequest):
            request.httpBody = try JSONEncoder().encode(registerRequest)
        }
        
        request.headers.add(.contentType("application/json"))
        request.headers.add(.accept("application/json"))
        
        request.method = method
        
        return request
    }
}
