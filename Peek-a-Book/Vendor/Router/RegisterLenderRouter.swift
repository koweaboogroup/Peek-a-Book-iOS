//
//  RegisterLenderRouter.swift
//  Peek-a-Book
//
//  Created by Annetta Carolina on 02/08/21.
//

import Alamofire

enum RegisterLenderRouter: URLRequestConvertible {
    
    case post(RegisterLenderRequest)
    
    var method: HTTPMethod {
        switch self {
        case .post: return .post
        }
    }
    
    var url: URL {
        return URL(string: Constant.Network.baseUrl + "/lenders")!
    }
    
    func asURLRequest() throws -> URLRequest {
        var request = URLRequest(url: url)
        
        switch self {
        case let .post(registerLenderRequest):
            request.httpBody = try JSONEncoder().encode(registerLenderRequest)
        }
        
        request.headers.add(.contentType("application/json"))
        request.headers.add(.accept("application/json"))
        
        request.method = method
        
        return request
    }
    
}
