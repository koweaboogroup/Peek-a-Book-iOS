//
//  RentRouter.swift
//  Peek-a-Book
//
//  Created by Muhammad Rifki Widadi on 04/08/21.
//

import Alamofire

struct ChangeStatusRequest: Codable {
    var status: Int
}

enum RentRouter: URLRequestConvertible {

    case getForRenter(id: Int)
    case getForLender(id: Int)
    case putForChangeStatus(id: Int, changeStatusRent: ChangeStatusRequest)

    var method: HTTPMethod {
        switch self {
        case .getForRenter: return .get
        case .getForLender: return .get
        case .putForChangeStatus: return .put
        }
    }
    
    var parameterId: String {
            switch self {
            case let .getForRenter(id): return String(id)
            case let .getForLender(id): return String(id)
            case let .putForChangeStatus(idRent, _): return String(idRent)
                
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
        case .putForChangeStatus(_, let changeStatusRequest):
            request.httpBody = try JSONEncoder().encode(changeStatusRequest)
        default:
            break
        }
        
        request.method = method
        
        return request
    }
}
