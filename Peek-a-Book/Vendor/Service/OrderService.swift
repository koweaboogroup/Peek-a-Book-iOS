//
//  OrderService.swift
//  Peek-a-Book
//
//  Created by Yossan Sandi Rahmadi on 05/08/21.
//

import Alamofire

class OrderService {
    static func getDetailOrder(orderId: Int, successCompletion: @escaping (Rent) -> Void, failCompletion: @escaping (AFError) -> Void) {
        
        BaseRequest.get(router: DetailOrderRouter.get(orderId: orderId)) { request in
            request.responseDecodable(of: [Rent].self) { response in
                switch response.result {
                case .success(let order):
                    successCompletion(order[0])
                case .failure(let error):
                    failCompletion(error)
                }
            }
        }
    }
}
