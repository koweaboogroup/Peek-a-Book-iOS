//
//  LenderProfileRouter.swift
//  Peek-a-Book
//
//  Created by Annetta Carolina on 05/08/21.
//

import Alamofire

enum LenderProfileRouter: URLRequestConvertible {
    
    case get(lenderId: Int)
    case put(lenderId: Int, editLenderProfileRequest: RegisterLenderRequest)
    
    var method: HTTPMethod {
        switch self {
        case .get: return .get
        case .put: return .put
        }
    }
    
    var baseUrl: URL {
        return URL(string: Constant.Network.baseUrl + "/lenders")!
    }
    
    var path: String {
        switch self {
        case .get(let lenderId):
            return String(lenderId)
        case .put(let lenderId, _):
            return String(lenderId)
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseUrl.appendingPathComponent(path)
        
        var request = URLRequest(url: url)
        
        switch self {
        case .get(_):
            break
        case .put(_, let editLenderProfileRequest):
            request.httpBody = try JSONEncoder().encode(editLenderProfileRequest)
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
