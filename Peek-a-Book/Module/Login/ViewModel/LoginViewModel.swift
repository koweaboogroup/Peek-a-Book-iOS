//
//  LoginViewModel.swift
//  Peek-a-Book
//
//  Created by Annetta Carolina on 30/07/21.
//

import Foundation
import RxSwift

class LoginViewModel {
    public let identifier : PublishSubject<String> = PublishSubject()
    public let password : PublishSubject<String> = PublishSubject()
    public let user : PublishSubject<User> = PublishSubject()
    public let loading : PublishSubject<Bool> = PublishSubject()
    
    public let buttonLoginPressed = PublishSubject<Bool>()
}
