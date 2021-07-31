//
//  LoginService.swift
//  Peek-a-Book
//
//  Created by Annetta Carolina on 30/07/21.
//

import Alamofire

class LoginService {
    static func login(loginRequest: LoginRequest, successCompletion: @escaping (LoginResponse) -> Void, failCompletion: @escaping (AFError) -> Void) {
        
        BaseRequest.post(router: LoginRouter.post(loginRequest)) { request in
            request.responseDecodable(of: LoginResponse.self) { response in
                
                switch response.result {
                case .success(let loginResponse):
                    successCompletion(loginResponse)
                case .failure(let error):
                    failCompletion(error)
                }
            }
        }
    }
}
