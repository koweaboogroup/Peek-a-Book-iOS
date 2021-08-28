//
//  InsertBookViewModel.swift
//  Peek-a-Book
//
//  Created by Yossan Sandi Rahmadi on 24/08/21.
//

import UIKit
import RxSwift

struct InsertBookViewModel {
    
    // MARK: - Variable (public)
    
    let loading: PublishSubject<Bool> = PublishSubject()
    let error: PublishSubject<String> = PublishSubject()
    
    let bookTitle: PublishSubject<String> = PublishSubject()
    let isbn: PublishSubject<String> = PublishSubject()
    let bookCondition: PublishSubject<Int> = PublishSubject()
    let genre: PublishSubject<Int> = PublishSubject()
    let language: PublishSubject<String> = PublishSubject()
    let totalPages: PublishSubject<Int> = PublishSubject()
    let rentCost: PublishSubject<Int> = PublishSubject()
    let image: PublishSubject<UIImage> = PublishSubject()
    
    // MARK: - Function (public)
    
    func addBookToCatalogue(title: String, isbn: String, genre: Int, bookId: Int?, bookCondition: Int, totalPages: Int, language: String, rentCost: Int, image: Data,  successCompletion: @escaping() -> Void) {
        
        self.loading.onNext(true)
        
        var bookId = bookId
        
        if bookId == nil {
            let bookRequest = [
                "title": title,
                "isbn": isbn,
                "book_genre": String(genre)
            ]
            
            BookService.addBook(bookRequest: bookRequest) { id in
                bookId = id
                
                let lenderBookRequest = LenderBookRequest(price: rentCost, bookCondition: bookCondition, lender: DataManager.shared.getUser()?.lender?.id ?? -1, book: bookId ?? -1, page: totalPages, language: language)
                
                BookCatalogueService.addBookIntoCatalogueWithImage(image: image, lenderBookRequest: lenderBookRequest) {
                    self.loading.onNext(false)
                    successCompletion()
                } failCompletion: { error in
                    self.loading.onNext(false)
                    self.error.onNext(error.errorDescription ?? "Error")
                }
            } failCompletion: { error in
                self.loading.onNext(false)
                self.error.onNext(error.errorDescription ?? "Error")
            }
        } else {
            let lenderBookRequest = LenderBookRequest(price: rentCost, bookCondition: bookCondition, lender: DataManager.shared.getUser()?.lender?.id ?? -1, book: bookId ?? -1, page: totalPages, language: language)
            
            BookCatalogueService.addBookIntoCatalogueWithImage(image: image, lenderBookRequest: lenderBookRequest) {
                self.loading.onNext(false)
                successCompletion()
            } failCompletion: { error in
                self.loading.onNext(false)
                self.error.onNext(error.errorDescription ?? "Error")
            }
        }
    }
    
    func getBookByTitle(title: String, successCompletion: @escaping(Int) -> Void, errorCompletion: @escaping() -> Void) {
        
        self.loading.onNext(true)
        
        BookService.getBookByTitle(title: title.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") { book in
            self.isbn.onNext(book.isbn ?? "")
            self.genre.onNext(book.bookGenre?.id ?? 0)
            
            self.loading.onNext(false)
            
            successCompletion(book.id ?? -1)
        } failCompletion: { error in
            self.error.onNext(error.errorDescription ?? "Error")
            
            self.loading.onNext(false)
            
            errorCompletion()
        } emptyDataCompletion: {
            self.loading.onNext(false)
            
            errorCompletion()
        }
    }
    
    func isAllTextFieldsFilled() -> Observable<Bool> {
        return Observable.combineLatest(
            bookTitle.asObservable().startWith(""),
            isbn.asObservable().startWith(""),
            bookCondition.asObservable().startWith(0),
            genre.asObservable().startWith(0),
            language.asObservable().startWith(""),
            totalPages.asObservable().startWith(0),
            rentCost.asObservable().startWith(0),
            image.asObservable().startWith(UIImage())
        )
        .map({ (bookTitle, isbn, bookCondition, genre, language, totalPage, rentCost, image) in
            return !bookTitle.isEmpty && !isbn.isEmpty && bookCondition > 0 && (genre == 1 || genre == 2) && !language.isEmpty && totalPage > 0 && rentCost > 0 && (image.cgImage != nil || image.ciImage != nil)
        })
        .startWith(false)
    }
    
}
