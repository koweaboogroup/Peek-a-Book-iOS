//
//  RentViewModel.swift
//  Peek-a-Book
//
//  Created by Muhammad Rifki Wildadi on 04/08/21.
//

import Foundation
import RxSwift

struct RentViewModel{
    public let orders: PublishSubject<[Order]> = PublishSubject()
    let error: PublishSubject<String> = PublishSubject()
    
    func getListRentAsUser(id: Int){
        RentService.getListRentTransaction(id: id) { rentResponse in
            self.orders.onNext(rentResponse)
        } failCompletion: { error in
            self.error.onNext(error.errorDescription!)
        }
    }
    
    func getAwatingRents() -> Observable<[Order]> {
        return orders.asObservable().map { orders in
            orders.filter { order in
                order.rent?.status == 0
            }
        }
    }
    
    func getShippingRents() -> Observable<[Order]> {
        return orders.asObservable().map { orders in
            orders.filter { order in
                order.rent?.status == 1
            }
        }
    }
    
    func getOngoingRents() -> Observable<[Order]> {
        return orders.asObservable().map { orders in
            orders.filter { order in
                order.rent?.status == 2
            }
        }
    }

    func getReturningRents() -> Observable<[Order]> {
        return orders.asObservable().map { orders in
            orders.filter { order in
                order.rent?.status == 3
            }
        }
    }
    
    func getDoneRents() -> Observable<[Order]> {
        return orders.asObservable().map { orders in
            orders.filter { order in
                order.rent?.status == 4
            }
        }
    }
}
