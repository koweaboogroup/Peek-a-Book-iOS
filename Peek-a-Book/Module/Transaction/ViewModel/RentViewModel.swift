//
//  RentViewModel.swift
//  Peek-a-Book
//
//  Created by Muhammad Rifki Wildadi on 04/08/21.
//

import Foundation
import RxSwift

struct RentViewModel{
    public let rents: PublishSubject<[Order]> = PublishSubject()
    let error: PublishSubject<String> = PublishSubject()
    
    func getListRentAsUser(id: Int){
        RentService.getListRentTransaction(id: id) { rentResponse in
            self.rents.onNext(rentResponse)
        } failCompletion: { error in
            self.error.onNext(error.errorDescription!)
        }
    }
}
