//
//  LenderProfileService.swift
//  Peek-a-Book
//
//  Created by Annetta Carolina on 05/08/21.
//

import Alamofire

class LenderProfileService {
    
    static func editLenderProfile(lenderId: Int, editLenderProfileRequest: RegisterLenderRequest, successCompletion: @escaping(RegisterLenderResponse) -> Void, failCompletion: @escaping (AFError) -> Void) {
        
        BaseRequest.put(router: LenderProfileRouter.put(lenderId: lenderId, editLenderProfileRequest: editLenderProfileRequest)) { request in
            request.responseDecodable(of: RegisterLenderResponse.self) { response in
                switch response.result {
                
                case .success(let editLenderProfileResponse):
                    successCompletion(editLenderProfileResponse)
                case .failure(let error):
                    failCompletion(error)
                }
            }
        }
    }
    
    static func getLenderProfile(lenderId: Int, successCompletion: @escaping(RegisterLenderResponse) -> Void, failCompletion: @escaping (AFError) -> Void) {
        
        BaseRequest.get(router: LenderProfileRouter.get(lenderId: lenderId)) { request in
            request.responseDecodable(of: RegisterLenderResponse.self) { response in
                
                switch response.result {
                case .success(let editLenderProfileResponse):
                    successCompletion(editLenderProfileResponse)
                case .failure(let error):
                    failCompletion(error)
                }
            }
        }
        
    }
}
