//
//  RentViewModel.swift
//  Peek-a-Book
//
//  Created by Muhammad Rifki Wildadi on 04/08/21.
//

import Foundation
import RxSwift

struct RentViewModel{
    public let orders: PublishSubject<[Rent]> = PublishSubject()
    let error: PublishSubject<String> = PublishSubject()
    
    func getListRentAsUser(id: Int){
        RentService.getListRenterTransaction(id: id) { rentResponse in
            self.orders.onNext(rentResponse)
        } failCompletion: { error in
            self.error.onNext(error.errorDescription!)
        }
    }

    func getListRentAsLender(id: Int){
        RentService.getListLenderTransaction(id: id) { rentResponse in
            self.orders.onNext(rentResponse)
        } failCompletion: { error in
            self.error.onNext(error.errorDescription!)
        }
    }
    
}
