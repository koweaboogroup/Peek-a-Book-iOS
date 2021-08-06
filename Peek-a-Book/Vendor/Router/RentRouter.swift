//
//  RentRouter.swift
//  Peek-a-Book
//
//  Created by Muhammad Rifki Widadi on 04/08/21.
//

import Alamofire

enum RentRouter: URLRequestConvertible {
    //nunggu parsing jwt -> id dari data manager
    //nunggu pembeda user dengan lender dari backend
    
    case get(id: String)
    
    var method: HTTPMethod {
        switch self {
        case .get: return .get
        }
    }
    
    var parameterId: String {
            switch self {
            case let .get(id): return id
            }
        }
    
    var url: URL {
        return URL(string: Constant.Network.baseUrl + "/rents?user.id=")!
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
        if let jwt = UserDefaults.standard.string(forKey: "jwt"){
            request.headers.add(.authorization(bearerToken: jwt))
        }
        
        request.method = method
        
        return request
    }
}
