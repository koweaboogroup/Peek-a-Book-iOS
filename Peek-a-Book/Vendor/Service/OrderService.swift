//
//  OrderService.swift
//  Peek-a-Book
//
//  Created by Yossan Sandi Rahmadi on 05/08/21.
//

import Alamofire

class OrderService {
    static func getDetailOrder(orderId: Int, successCompletion: @escaping (Order) -> Void, failCompletion: @escaping (AFError) -> Void) {
        BaseRequest.get(router: DetailOrderRouter.get(orderId: orderId)) { request in
            request.responseDecodable(of: Order.self) { response in
                switch response.result {
                case .success(let order):
                    successCompletion(order)
                case .failure(let error):
                    failCompletion(error)
                }
            }
        }
    }
}
