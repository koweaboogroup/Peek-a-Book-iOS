//
//  BookCatalogueRouter.swift
//  Peek-a-Book
//
//  Created by Yossan Sandi Rahmadi on 05/08/21.
//

import Alamofire

enum BookCatalogueRouter: URLRequestConvertible {
    
    case get, addBookIntoCatalogue(lenderBookRequest: LenderBookRequest)
    
    var method: HTTPMethod {
        switch self {
        case .get: return .get
        case .addBookIntoCatalogue: return .post
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
        
        switch self {
        case .get: break
        case .addBookIntoCatalogue(lenderBookRequest: let lenderBookRequest):
            request.httpBody = try JSONEncoder().encode(lenderBookRequest)
        }
        
        if let jwt = UserDefaults.standard.string(forKey: "jwt"){
            request.headers.add(.authorization(bearerToken: jwt))
        }
        
        request.method = method
        
        return request
    }
}

