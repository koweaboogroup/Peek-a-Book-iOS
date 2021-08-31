//
//  DetailBookViewModel.swift
//  Peek-a-Book
//
//  Created by Arif Rahman on 01/08/21.
//

import Foundation
import RxSwift

class DetailBookViewModel {
    
    public let bookDetail : PublishSubject<LenderBook> = PublishSubject()
    public let loading : PublishSubject<Bool> = PublishSubject()
    public let error : PublishSubject<String> = PublishSubject()
    
    func getDetailBook(id: String) {
        self.loading.onNext(true)
        BookService.getBookDetail(id: id) { book in
            self.loading.onNext(false)
            if let bookResponse = book {
                self.bookDetail.onNext(bookResponse)
            } else {
                self.error.onNext("Data Tidak Ditemukan")
            }
        } failCompletion: { error in
            self.loading.onNext(false)
            self.error.onNext(error.errorDescription ?? "Error")
        }
    }
    
    //    MARK: - TODO: async problem
    
    func updateCartFromServer(successCompletion: @escaping (Bool) -> Void) {
        self.loading.onNext(true)
        let dataManager = DataManager.shared
        let lenderBooks = dataManager.getCart()
        
        dataManager.deleteCart()
        
        for lenderBook in lenderBooks {
            BookService.getBookDetail(id: String(lenderBook.id ?? -1)) { book in
                if let bookResponse = book {
                    dataManager.addItemToCart(lenderBook: bookResponse)
                } else {
                    self.error.onNext("Data Tidak Ditemukan")
                }
            } failCompletion: { error in
                
                self.error.onNext(error.errorDescription ?? "Error")
            }
        }
        
        if !dataManager.getCart().isEmpty {
            var isAllBooksAvailable = true
            for lenderBook in dataManager.getCart() {
                if lenderBook.isAvailable == false {
                    isAllBooksAvailable = false
                }
            }
            print("isAvailable", isAllBooksAvailable)
            successCompletion(isAllBooksAvailable)
        }
    }
}
