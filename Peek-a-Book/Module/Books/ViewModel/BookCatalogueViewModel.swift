//
//  BookCatalogueViewModel.swift
//  Peek-a-Book
//
//  Created by Yossan Sandi Rahmadi on 05/08/21.
//

import Foundation
import RxSwift

struct BookCatalogueViewModel {
    let bookCatalogue: PublishSubject<BookCatalogue> = PublishSubject()
    let loading: PublishSubject<Bool> = PublishSubject()
    let error: PublishSubject<String> = PublishSubject()
    
    func getBookCatalogue() {
        self.loading.onNext(true)
        
        BookCatalogueService.getBookCatalogue { bookCatalogue in
            self.bookCatalogue.onNext(bookCatalogue)
            self.loading.onNext(false)
        } failCompletion: { error in
            self.error.onNext(error.errorDescription ?? "Error")
            self.loading.onNext(false)
        }

    }
}
