//
//  RegisterViewModel.swift
//  Peek-a-Book
//


import Foundation
import RxSwift

struct RegisterViewModel {
    let name: PublishSubject<String> = PublishSubject()
    let email: PublishSubject<String> = PublishSubject()
    let whatsappNumber: PublishSubject<String> = PublishSubject()
    let password: PublishSubject<String> = PublishSubject()
    let confirmPassword: PublishSubject<String> = PublishSubject()
    let loading: PublishSubject<Bool> = PublishSubject()
    let error: PublishSubject<String> = PublishSubject()
    
    func isAllTextFieldFilled() -> Observable<Bool> {
        return Observable.combineLatest(
            name.asObserver().startWith(""),
            email.asObserver().startWith(""),
            whatsappNumber.asObserver().startWith(""),
            password.asObserver().startWith(""),
            confirmPassword.asObserver().startWith("")
        )
        .map { name, email, whatsappNumber, password, confirmPassword in
            return !name.isEmpty && !email.isEmpty && !whatsappNumber.isEmpty && !password.isEmpty && !confirmPassword.isEmpty
        }
        .startWith(false)
    }
    
    public func register(username: String, email: String, password: String, phoneNumber: String, alamat: String, provinsi: String, kota: String, kelurahan: String, kecamatan: String, longtitude: Float, latitude: Float) {
        
        self.loading.onNext(true)
        
        let registerRequest = RegisterRequest(username: username, email: email, password: password, phoneNumber: phoneNumber, alamat: alamat, provinsi: provinsi, kota: kota, kelurahan: kelurahan, kecamatan: kecamatan, longtitude: longtitude, latitude: latitude)
        
        RegisterService.register(registerRequest: registerRequest) { registerResponse in
            
            self.loading.onNext(false)
            //kalo success ngapain?
            
            
        } failCompletion: { error in
            
            self.loading.onNext(false)
            self.error.onNext(error.errorDescription ?? "Error")
            fatalError()
            
        }
    }
}
