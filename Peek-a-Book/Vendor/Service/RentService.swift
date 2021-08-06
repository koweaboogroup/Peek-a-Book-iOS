//
//  RentService.swift
//  Peek-a-Book
//
//  Created by Muhammad Rifki Widadi on 04/08/21.
//

import Alamofire

class RentService {
    
    static func getListRentTransaction(id: Int, successCompletion: @escaping ([RentResponse]) -> Void, failCompletion: @escaping (AFError) -> Void) {
        
        BaseRequest.get(router: RentRouter.get(id: id)) { request in
            request.responseDecodable(of: [RentResponse].self) { response in
                
                switch response.result {
                case .success(let rentResponse):
                    successCompletion(rentResponse)
                case .failure(let error):
                    failCompletion(error)
                }
            }
        }
    }
}
