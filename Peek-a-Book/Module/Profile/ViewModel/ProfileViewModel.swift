//
//  ProfileViewModel.swift
//  Peek-a-Book
//
//  Created by Arif Rahman on 06/08/21.
//

import Foundation
import RxSwift
class ProfileViewModel {
    public let user: PublishSubject<User> = PublishSubject()
    public let error: PublishSubject<String> = PublishSubject()
    public let loading: PublishSubject<Bool> = PublishSubject()
    
    func fetchProfile() {
        self.loading.onNext(true)
        ProfileService.getProfile(userId: DataManager.shared.getUserIdByJwt()) { user in
            self.loading.onNext(false)
            self.user.onNext(user)
        } failCompletion: { error in
            self.loading.onNext(false)
            self.error.onNext(error.errorDescription ?? "Data Tidak Ditemukan")
        }
    }
    
    func logout() {
        let jwtUserDefaults = "jwt"
        UserDefaults.standard.removeObject(forKey: jwtUserDefaults)
    }
}
