//
//  DetailOrderViewModel.swift
//  Peek-a-Book
//
//  Created by Yossan Sandi Rahmadi on 05/08/21.
//

import Foundation
import RxSwift

struct DetailOrderViewModel {
    let loading: PublishSubject<Bool> = PublishSubject()
    let error: PublishSubject<String> = PublishSubject()
    let user: PublishSubject<User> = PublishSubject()
    
    let order: PublishSubject<Rent> = PublishSubject()
    
    func getDetailOrder(orderId: Int) {
        self.loading.onNext(true)
        
        OrderService.getDetailOrder(orderId: orderId) { order in
            self.order.onNext(order)
            self.loading.onNext(false)
        } failCompletion: { error in
            self.loading.onNext(false)
            self.error.onNext(error.errorDescription ?? "Error")
        }
    }
    
    func getProfile(userId: Int) {
        ProfileService.getProfile(userId: userId) { user in
            self.user.onNext(user)
        } failCompletion: { error in
            self.error.onNext(error.errorDescription ?? "Data Tidak Ditemukan")
        }
    }
}
