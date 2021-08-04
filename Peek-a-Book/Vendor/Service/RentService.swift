//
//  RentService.swift
//  Peek-a-Book
//
//  Created by Muhammad Rifki Widadi on 04/08/21.
//

import Alamofire

class RentService {
    
    static func getListRentTransaction(id: Int, successCompletion: @escaping (RegisterResponse) -> Void, failCompletion: @escaping (AFError) -> Void) {
        
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
