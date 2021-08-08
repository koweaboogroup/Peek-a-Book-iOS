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
            }else{
                self.error.onNext("Data Tidak Ditemukan")
            }
        } failCompletion: { error in
            self.loading.onNext(false)
            self.error.onNext(error.errorDescription ?? "Error")
        }
    }
    
    func addToCart(_ cart: [LenderBook], _ lenderBook: LenderBook, onSuccessCompletion: @escaping ([LenderBook]) -> Void, onErrorCompletion: @escaping () -> Void) {
        
        if cart.isEmpty {
            DataManager.shared.addItemToCart(lenderBook: lenderBook)
            onSuccessCompletion(DataManager.shared.getCart())
        }else{
            if lenderBook.lender?.id == cart[0].lender?.id {
                DataManager.shared.addItemToCart(lenderBook: lenderBook)
                onSuccessCompletion(DataManager.shared.getCart())
            }else{
                onErrorCompletion()
            }
        }
    }
}
