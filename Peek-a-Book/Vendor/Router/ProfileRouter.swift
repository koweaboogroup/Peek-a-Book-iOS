//
//  ProfileRouter.swift
//  Peek-a-Book
//
//  Created by Arif Rahman on 06/08/21.
//

import Foundation
import Alamofire

enum ProfileRouter: URLRequestConvertible {
    
    case get(userId: Int)
    
    var method: HTTPMethod {
        switch self {
        case .get: return .get
        }
    }
    
    var url: URL {
        switch self {
        case .get(let userId):
            return URL(string: Constant.Network.baseUrl + "/users/\(userId)")!
        }
    }

    func asURLRequest() throws -> URLRequest {
        var request = URLRequest(url: url)
        
        switch self {
        case .get:
            break
        }
        
        request.headers.add(.contentType("application/json"))
        request.headers.add(.accept("application/json"))
        if let jwt = UserDefaults.standard.string(forKey: "jwt"){
            request.headers.add(.authorization(bearerToken: jwt))
        }
        
        request.method = method
        
        return request
    }
    
}
