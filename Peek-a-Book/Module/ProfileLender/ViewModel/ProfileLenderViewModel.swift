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
    let listBook: PublishSubject<[LenderBook]> = PublishSubject()
    
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
    
    func getListBook(lenderId: Int, userPenyewa: Bool){
        var books = [LenderBook]()
        if userPenyewa == false {
            books.append(LenderBook(id: 0, price: 0, bookCondition: nil, lender: nil, book: nil, page: 0, language: "", publishedAt: "", createdAt: "", updatedAt: "", images: []))
        }
        
        BookService.getListBook { book in
            for item in book {
                if item.lender?.id == lenderId {
                    books.append(LenderBook(id: item.id, price: item.price, bookCondition: item.bookCondition, lender: item.lender, book: item.book, page: item.page, language: item.language, publishedAt: item.publishedAt, createdAt: item.createdAt, updatedAt: item.updatedAt, images: item.images))
                    self.listBook.onNext(books)
                }
            }
        } failCompletion: { error in
            self.error.onNext(error.errorDescription ?? "Data Tidak Ditemukan")
        }
    }
    
    
}

