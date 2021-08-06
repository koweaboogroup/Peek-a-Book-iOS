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
    public let urbanVillage: PublishSubject<String> = PublishSubject()
    public let districtName : PublishSubject<String> = PublishSubject()
    public let cityName : PublishSubject<String> = PublishSubject()
    public let provName : PublishSubject<String> = PublishSubject()
    
    public let checkBoxClicked : PublishSubject<Bool> = PublishSubject()
    
    
    func getAllAddressFieldsObservable() -> Observable<[String]> {
        return Observable.combineLatest(
            address.asObservable().startWith(""),
            urbanVillage.asObservable().startWith(""),
            districtName.asObservable().startWith(""),
            cityName.asObservable().startWith(""),
            provName.asObservable().startWith("")
        )
        .map { address, urbanVillage, districtName, cityName, provName in
            return [address, urbanVillage, districtName, cityName, provName]
        }
        .startWith(["", "", "", "", ""])
    }
    
    func isAllAddressFieldsFilled() -> Observable<Bool> {
        Observable.combineLatest(address.asObservable().startWith(""), urbanVillage.asObservable().startWith(""), districtName.asObservable().startWith(""), cityName.asObservable().startWith(""), provName.asObservable().startWith(""))
            .map { address, urbanVillage, districtName, cityName, provName in
                return !address.isEmpty && !urbanVillage.isEmpty && !districtName.isEmpty && !cityName.isEmpty && !provName.isEmpty
            }
            .startWith(false)
    }
}
