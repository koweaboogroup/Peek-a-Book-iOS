//
//  RentService.swift
//  Peek-a-Book
//
//  Created by Muhammad Rifki Widadi on 04/08/21.
//

import Alamofire

class RentService {
    
    static func getListRenterTransaction(id: Int, successCompletion: @escaping ([Rent]) -> Void, failCompletion: @escaping (AFError) -> Void) {
        BaseRequest.get(router: RentRouter.getForRenter(id: id)) { request in
            request.responseJSON { item in
                print("item mantap \(item)")
            }
            request.responseDecodable(of: [Rent].self) { response in
                debugPrint(response)
                switch response.result {
                case .success(let rentResponse):
                    successCompletion(rentResponse)
                case .failure(let error):
                    failCompletion(error)
                }
            }
        }
    }
    
    static func getListLenderTransaction(id: Int, successCompletion: @escaping ([Rent]) -> Void, failCompletion: @escaping (AFError) -> Void) {
        BaseRequest.get(router: RentRouter.getForLender(id: id)) { request in
            request.responseDecodable(of: [Rent].self) { response in
                switch response.result {
                case .success(let rentResponse):
                    successCompletion(rentResponse)
                case .failure(let error):
                    failCompletion(error)
                }
            }
        }
    }

    static func changeStatus(idRent: Int, statusRent: Int, successCompletion: @escaping (Rent) -> Void, failCompletion: @escaping (AFError) -> Void) {
        BaseRequest.put(router: RentRouter.putForChangeStatus(id: idRent, changeStatusRent: ChangeStatusRequest(status: statusRent))) { request in
            request.responseDecodable(of: Rent.self) { response in
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
