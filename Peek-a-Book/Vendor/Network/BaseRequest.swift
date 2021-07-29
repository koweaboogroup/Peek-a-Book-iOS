//
//  BaseRequest.swift
//  Peek-a-Book
//
//  Created by Yossan Sandi Rahmadi on 29/07/21.
//

import Alamofire

class BaseRequest {
    
//    MARK: - GET Method
    static func get(router: URLRequestConvertible, completionHandler: @escaping (DataRequest) -> Void) {
        let request = AF.request(router)
            .validate(statusCode: 200..<300)
        
        completionHandler(request)
    }
    
//    MARK: - POST Method
    static func post(router: URLRequestConvertible, completionHandler: @escaping (DataRequest) -> Void) {
        let request = AF.request(router)
            .validate(statusCode: 200..<300)
        
        completionHandler(request)
    }
}

