//
//  AlamatViewModel.swift
//  Peek-a-Book
//
//  Created by Arif Rahman on 05/08/21.
//

import Foundation
import RxSwift
import RxCocoa

class AddressViewModel {
    
    public let address: PublishSubject<String> = PublishSubject()
    public let districtName : PublishSubject<String> = PublishSubject()
    public let cityName : PublishSubject<String> = PublishSubject()
    public let provName : PublishSubject<String> = PublishSubject()
}
