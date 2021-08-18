//
//  CheckoutViewModel.swift
//  Peek-a-Book
//
//  Created by Arif Rahman on 08/08/21.
//

import Foundation
import RxSwift

struct CheckoutViewModel {
    let periodOfTime: PublishSubject<Int> = PublishSubject()
    let shippingMethod: PublishSubject<String> = PublishSubject()
    let itemsPrice: PublishSubject<Int> = PublishSubject()
    let bookRentalFee: PublishSubject<Int> = PublishSubject()
    let feeTotalEstimation: PublishSubject<Int> = PublishSubject()
    
    func createNewRent(rentRequest: RentRequest, successCompletion: @escaping (Int) -> Void) {
        
        RentService.createRent(rentRequest: rentRequest) { rentRequest in
            successCompletion(rentRequest.id ?? -1)
        } failCompletion: { error in
            debugPrint(error)
        }
    }
    
    func isAllFieldsFilled() -> Observable<Bool> {
        Observable.combineLatest(
            periodOfTime.asObservable().startWith(0),
            shippingMethod.asObservable().startWith("cod")
        )
        .map { periodOfTime, shippingMethod in
            return periodOfTime != 0 && !shippingMethod.isEmpty
        }
        .startWith(false)
    }
}
