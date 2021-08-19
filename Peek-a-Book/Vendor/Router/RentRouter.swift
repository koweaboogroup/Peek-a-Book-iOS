//
//  RentRouter.swift
//  Peek-a-Book
//
//  Created by Muhammad Rifki Widadi on 04/08/21.
//

import Alamofire

enum RentRouter: URLRequestConvertible {
    
    case getForRenter(id: Int)
    case getForLender(id: Int)
    case putForChangeStatus(id: Int)
    case createRent(rentRequest: RentRequest)
    
    var method: HTTPMethod {
        switch self {
        case .getForRenter: return .get
        case .getForLender: return .get
        case .putForChangeStatus: return .put
        case .createRent: return .post
        }
    }
    
    var parameterId: String {
        switch self {
        case let .getForRenter(id): return String(id)
        case let .getForLender(id): return String(id)
        case let .putForChangeStatus(id): return String(id)
        case .createRent: return ""
        }
    }
    
    var url: URL {
        switch self {
        case .getForRenter:
            return URL(string: Constant.Network.baseUrl + "/rents?user.id=\(parameterId)")!
        case .getForLender:
            return URL(string: Constant.Network.baseUrl + "/rents?lender_books.lender.id=\(parameterId)")!
        case .putForChangeStatus:
            return URL(string: Constant.Network.baseUrl + "/rents/\(parameterId)")!
        case .createRent:
            return URL(string: Constant.Network.baseUrl + "/rents") ?? URL(fileURLWithPath: "")
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        var request = URLRequest(url: url)
        
        request.headers.add(.contentType("application/json"))
        request.headers.add(.accept("application/json"))
        
        if let jwt = UserDefaults.standard.string(forKey: "jwt"){
            request.headers.add(.authorization(bearerToken: jwt))
        }
        
        switch self {
        case .getForRenter: break
        case .getForLender: break
        case .putForChangeStatus: break
        case let .createRent(rentRequest):
            request.httpBody = try JSONEncoder().encode(rentRequest)
        }
        
        request.method = method
        
        return request
    }
}
