//
//  DetailOrderRouter.swift
//  Peek-a-Book
//
//  Created by Yossan Sandi Rahmadi on 05/08/21.
//

import Alamofire

enum DetailOrderRouter: URLRequestConvertible {
    
    case get(orderId: Int)
    
    var method: HTTPMethod {
        switch self {
        case .get: return .get
        }
    }
    
    var baseUrl: URL {
        return URL(string: Constant.Network.baseUrl + "/rent-details")!
    }
    
    var path: String {
        switch self {
        case .get(let orderId): return String(orderId)
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseUrl.appendingPathComponent(path)
        
        var request = URLRequest(url: url)
        
        request.headers.add(.contentType("application/json"))
        request.headers.add(.accept("application/json"))
        
        request.method = method
        
        return request
    }
    
}
