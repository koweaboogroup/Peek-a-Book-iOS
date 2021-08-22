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
    let user: PublishSubject<RegisterLenderResponse> = PublishSubject()
    
    let loading: PublishSubject<Bool> = PublishSubject()
    let error: PublishSubject<String> = PublishSubject()
    
    let detailAddressPressed: PublishSubject<Bool> = PublishSubject()
    
    func isStoreNameFilled() -> Observable<Bool> {
        return storeName.asObserver().startWith("")
            .map { (storeName) in
                return !storeName.isEmpty
            }.startWith(false)
    }
    
    public func registerLender(name: String, bio: String, user: String, alamat: String, provinsi: String, kota: String, kelurahan: String, kecamatan: String, longtitude: Float, latitude: Float) {
        
        self.loading.onNext(true)
        
        let registerLenderRequest = RegisterLenderRequest(name: name, bio: bio, user: user, alamat: alamat, provinsi: provinsi, kota: kota, kelurahan: kelurahan, kecamatan: kecamatan, longtitude: longtitude, latitude: latitude)
        
        RegisterLenderService.registerLender(registerLenderRequest: registerLenderRequest) { registerLenderResponse in
            self.loading.onNext(false)
            self.user.onNext(registerLenderResponse)
            
        } failCompletion: { error in
            self.loading.onNext(false)
            self.error.onNext(error.errorDescription ?? "Error")
        }
    }
}
