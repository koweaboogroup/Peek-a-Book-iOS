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
    
//    MARK: - PUT Method
    static func put(router: URLRequestConvertible, completionHandler: @escaping (DataRequest) -> Void) {
        let request = AF.request(router)
            .validate(statusCode: 200..<300)
        
        completionHandler(request)
    }
    
//    MARK: - MultiPart
    static func upload(file: Data, body: Data, completionHandler: @escaping (DataResponse<LenderBook, AFError>) -> Void) {
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(file, withName: "files.images")
            
            multipartFormData.append(body, withName: "data")
        }, to: Constant.Network.baseUrl + "/lender-books")
            .responseDecodable(of: LenderBook.self) { response in
                completionHandler(response)
            }
    }
}

