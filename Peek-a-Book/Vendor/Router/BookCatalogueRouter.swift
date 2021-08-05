//
//  BookCatalogueRouter.swift
//  Peek-a-Book
//
//  Created by Yossan Sandi Rahmadi on 05/08/21.
//

import Alamofire

enum BookCatalogueRouter: URLRequestConvertible {
    
    case get
    
    var method: HTTPMethod {
        switch self {
        case .get: return .get
        }
    }
    
    var url: URL {
        let lenderId = DataManager.shared.getLenderId()
        return URL(string: Constant.Network.baseUrl + "/lender-books?lender.id=\(lenderId)")!
    }
    
    func asURLRequest() throws -> URLRequest {
        var request = URLRequest(url: url)
        
        request.headers.add(.contentType("application/json"))
        request.headers.add(.accept("application/json"))
        
        request.method = method
        
        return request
    }
}

