//
//  BaseRequest.swift
//  Peek-a-Book
//
//  Created by Yossan Sandi Rahmadi on 29/07/21.
//

import Alamofire

enum Router: URLRequestConvertible {
    
//    method(route)
    case get(String), post(String)
    
    var baseURL: URL {
        return URL(string: Constant.Network.baseUrl)!
    }
    
    var method: HTTPMethod {
        switch self {
        case .get: return .get
        case .post: return .post
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        var url: URL
        
//        combine base URL with the route
        switch self {
        case let .get(route):
            url = baseURL.appendingPathComponent(route)
        case let .post(route):
            url = baseURL.appendingPathComponent(route)
        }
        
        var request = URLRequest(url: url)
        
        request.method = method
        
//        Add header
//        request.headers.add(.authorization(bearerToken: ""))
        
        return request
    }
}


class BaseRequest {
    static func get(route: String, completionHandler: @escaping (DataRequest) -> Void) {
        let request = AF.request(Router.get(route))
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
        
        completionHandler(request)
    }
}

