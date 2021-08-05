//
//  RentViewModel.swift
//  Peek-a-Book
//
//  Created by Muhammad Rifki Wildadi on 04/08/21.
//

import Foundation
import RxSwift

struct RentViewModel{
    public let rent: PublishSubject<[RentResponse]> = PublishSubject()
    let error: PublishSubject<String> = PublishSubject()
    
    func getListRentAsUser(id: String){
        RentService.getListRentTransaction(id: id) { rentResponse in
            self.rent.onNext(rentResponse)
        } failCompletion: { error in
            self.error.onNext(error.errorDescription!)
        }
    }
    
    
    
}
