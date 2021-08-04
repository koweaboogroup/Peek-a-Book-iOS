//
//  RegisterLenderViewModel.swift
//  Peek-a-Book
//
//  Created by Annetta Carolina on 02/08/21.
//

import Foundation
import RxSwift

struct RegisterLenderViewModel {
    let storeName: PublishSubject<String> = PublishSubject()
    
    func isStoreNameFilled() -> Observable<Bool> {
        return storeName.asObserver().startWith("")
            .map { (storeName) in
                return !storeName.isEmpty
            }.startWith(false)
    }
}
