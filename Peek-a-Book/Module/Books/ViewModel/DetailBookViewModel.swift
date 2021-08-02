//
//  DetailBookViewModel.swift
//  Peek-a-Book
//
//  Created by Arif Rahman on 01/08/21.
//

import Foundation
import RxSwift

class DetailBookViewModel {
    
    public let bookDetail : PublishSubject<Book> = PublishSubject()
    public let loading : PublishSubject<Bool> = PublishSubject()
    public let error : PublishSubject<String> = PublishSubject()
    
    func getDetailBook(id: String) {
        self.loading.onNext(true)
        let bookRequest = BookRequest()
        
        BookService.getBookDetail(bookRequest: bookRequest) { book in
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
}