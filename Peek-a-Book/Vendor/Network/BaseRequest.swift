//
//  BaseRequest.swift
//  Peek-a-Book
//
//  Created by Yossan Sandi Rahmadi on 29/07/21.
//

import Alamofire

class BaseRequest {
    
//    MARK: GET Method
    static func get(route: String, completionHandler: @escaping (DataRequest) -> Void) {
        let request = AF.request(Router.get(route))
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
        
        completionHandler(request)
    }
    
}

