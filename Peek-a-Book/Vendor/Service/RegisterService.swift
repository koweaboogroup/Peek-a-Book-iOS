//
//  RegisterService.swift
//  Peek-a-Book
//
//  Created by Annetta Carolina on 02/08/21.
//

import Alamofire

class RegisterService {
    
    static func register(registerRequest: RegisterRequest, successCompletion: @escaping (RegisterResponse) -> Void, failCompletion: @escaping (AFError) -> Void) {
        
        BaseRequest.post(router: RegisterRouter.post(registerRequest)) { request in
            request.responseDecodable(of: RegisterResponse.self) { response in
                
                switch response.result {
                case .success(let registerResponse):
                    successCompletion(registerResponse)
                case .failure(let error):
                    failCompletion(error)
                }
            }
        }
    }
}
