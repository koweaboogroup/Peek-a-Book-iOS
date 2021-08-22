//
//  LoginViewModel.swift
//  Peek-a-Book
//
//  Created by Annetta Carolina on 30/07/21.
//

import Foundation
import RxSwift

struct LoginViewModel {
    
    // MARK: - Variable
    
    let user : PublishSubject<User> = PublishSubject()
    let loading : PublishSubject<Bool> = PublishSubject()
    let error : PublishSubject<String> = PublishSubject()
    
    let identifier: PublishSubject<String> = PublishSubject()
    let password: PublishSubject<String> = PublishSubject()
    
    let buttonLoginPressed = PublishSubject<Bool>()
    let buttonRegisterPressed = PublishSubject<Bool>()
    
    // MARK: Function

    func login(parameters: [String: String]) {

        self.loading.onNext(true)
        
        LoginService.login(parameters: parameters) { loginResponse in
            self.loading.onNext(false)
            
            let jwtUserDefaults = "jwt"
            UserDefaults.standard.string(forKey: jwtUserDefaults)
            UserDefaults.standard.set(loginResponse.jwt, forKey: jwtUserDefaults)
            
            if let responseUser = loginResponse.user {
                self.user.onNext(responseUser)
                DataManager.shared.setUser(user: responseUser)
            } else {
                self.error.onNext("Data Tidak Ditemukan")
            }
            
        } failCompletion: { error in
            self.loading.onNext(false)
            self.error.onNext(error.errorDescription ?? "Error")
        }
    }
    
    func isAllTextFieldsFilled() -> Observable<Bool> {
        return Observable.combineLatest(identifier.asObservable().startWith(""), password.asObservable().startWith(""))
            .map { identifier, password in
                return !identifier.isEmpty && !password.isEmpty
            }
            .startWith(false)
    }
}
