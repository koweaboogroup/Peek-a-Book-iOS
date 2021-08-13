//
//  EditProfileLenderViewModel.swift
//  Peek-a-Book
//
//  Created by Annetta Carolina on 05/08/21.
//

import Foundation
import RxSwift

struct ProfileLenderViewModel {
    let lenderProfile: PublishSubject<RegisterLenderResponse> = PublishSubject()
    let storeName: PublishSubject<String> = PublishSubject()
    
    let loading: PublishSubject<Bool> = PublishSubject()
    let error: PublishSubject<String> = PublishSubject()
    
    func isStoreNameFilled() -> Observable<Bool> {
        return storeName.asObserver().startWith("")
            .map { (storeName) in
                return !storeName.isEmpty
            }.startWith(false)
    }
    
    func editLenderProfile(lenderId: Int, name: String?, bio: String?, user: String?, alamat: String?, provinsi: String?, kota: String?, kelurahan: String?, kecamatan: String?, longtitude: Float?, latitude: Float?, successCompletion: @escaping () -> Void) {
        
        self.loading.onNext(true)
        
        let editLenderProfileRequest = RegisterLenderRequest(name: name, bio: bio, user: user, alamat: alamat, provinsi: provinsi, kota: kota, kelurahan: kelurahan, kecamatan: kecamatan, longtitude: longtitude, latitude: latitude)
        
        LenderProfileService.editLenderProfile(lenderId: lenderId, editLenderProfileRequest: editLenderProfileRequest) { lenderProfile in
            self.loading.onNext(false)
            
            self.lenderProfile.onNext(lenderProfile)
            successCompletion()
        } failCompletion: { error in
            self.loading.onNext(false)
            self.error.onNext(error.errorDescription ?? "Error")
            fatalError()
        }

    }
    
    func getLenderProfile(lenderId: Int) {
        
        self.loading.onNext(true)
        
        LenderProfileService.getLenderProfile(lenderId: lenderId) { lenderProfile in
            self.loading.onNext(false)
            self.lenderProfile.onNext(lenderProfile)
        } failCompletion: { error in
            self.loading.onNext(false)
            self.error.onNext(error.errorDescription ?? "Error")
        }

        
        
        
    }
}

