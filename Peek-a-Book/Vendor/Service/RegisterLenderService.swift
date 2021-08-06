//
//  RegisterLenderService.swift
//  Peek-a-Book
//
//  Created by Annetta Carolina on 05/08/21.
//

import Alamofire

class RegisterLenderService {
    
    static func registerLender (registerLenderRequest: RegisterLenderRequest, successCompletion: @escaping (RegisterLenderResponse) -> Void, failCompletion: @escaping (AFError) -> Void) {
        
        BaseRequest.post(router: RegisterLenderRouter.post(registerLenderRequest)) { request in
            request.responseDecodable(of: RegisterLenderResponse.self) { response in
                
                switch response.result {
                case .success(let registerLenderResponse):
                    successCompletion(registerLenderResponse)
                case .failure(let error):
                    failCompletion(error)
                }
                
            }
        }
    }
    
}
