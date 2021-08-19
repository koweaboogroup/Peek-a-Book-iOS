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

    func fetchProfile() {
        ProfileService.getProfile(userId: DataManager.shared.getUserIdByJwt()) { user in
            self.user.onNext(user)
        } failCompletion: { error in
            self.error.onNext(error.errorDescription ?? "Data Tidak Ditemukan")
        }
    }
    
    func logout() {
        let jwtUserDefaults = "jwt"
        UserDefaults.standard.removeObject(forKey: jwtUserDefaults)
    }
}
