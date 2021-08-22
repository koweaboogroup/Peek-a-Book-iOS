//
//  ProfileService.swift
//  Peek-a-Book
//
//  Created by Arif Rahman on 06/08/21.
//

import Foundation
import Alamofire
class ProfileService {
    static func getProfile(userId: Int, successCompletion: @escaping(User) -> Void, failCompletion: @escaping (AFError) -> Void) {
        
        BaseRequest.get(router: ProfileRouter.get(userId: userId)) { request in
            request.responseDecodable(of: User.self) { response in
                
                switch response.result {
                case .success(let userProfile):
                    successCompletion(userProfile)
                case .failure(let error):
                    failCompletion(error)
                }
            }
        }
        
    }
}
