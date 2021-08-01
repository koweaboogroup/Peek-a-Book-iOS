//
//  RegisterViewModel.swift
//  Peek-a-Book
//
//  Created by Yossan Sandi Rahmadi on 01/08/21.
//

import Foundation
import RxSwift

struct RegisterViewModel {
    let name: PublishSubject<String> = PublishSubject()
    let email: PublishSubject<String> = PublishSubject()
    let whatsappNumber: PublishSubject<String> = PublishSubject()
    let password: PublishSubject<String> = PublishSubject()
    let confirmPassword: PublishSubject<String> = PublishSubject()
    
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
    
    func isPasswordConfirmed() -> Observable<Bool> {
        return Observable.combineLatest(password.asObserver().startWith(""), confirmPassword.asObserver().startWith(""))
            .map { password, confirmPassword in
                return password == confirmPassword
            }
            .startWith(false)
    }
    
    
//    MARK: Combine all validations
    func isValid() -> Observable<Bool> {
        return Observable.combineLatest(isAllTextFieldFilled(), isPasswordConfirmed())
            .map { isAllTextFieldFilled, isPasswordConfirmed in
                return isAllTextFieldFilled && isPasswordConfirmed
            }
            .startWith(false)
    }
}
