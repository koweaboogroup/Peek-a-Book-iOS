//
//  LoginViewModel.swift
//  Peek-a-Book
//
//  Created by Annetta Carolina on 30/07/21.
//

import Foundation
import RxSwift

class LoginViewModel {
    public let user : PublishSubject<User> = PublishSubject()
    public let loading : PublishSubject<Bool> = PublishSubject()
    public let error : PublishSubject<String> = PublishSubject()
    
    public let buttonLoginPressed = PublishSubject<Bool>()
    
    public func login(identifier: String, password: String) {
        
        self.loading.onNext(true)
        
        let loginRequest = LoginRequest(identifier: identifier, password: password)
        
        LoginService.login(loginRequest: loginRequest) { loginResponse in
            self.loading.onNext(false)
            
            //kalo success
            let jwtUserDefaults = "jwt"
            UserDefaults.standard.string(forKey: jwtUserDefaults)
            UserDefaults.standard.set(loginResponse.jwt, forKey: jwtUserDefaults)
            
            if let responseUser = loginResponse.user {
                self.user.onNext(responseUser)
            } else {
                self.error.onNext("Data Tidak Ditemukan")
            }
            
        } failCompletion: { error in
            self.loading.onNext(false)
            self.error.onNext(error.errorDescription ?? "Error")
        }
        
    }
}
