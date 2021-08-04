//
//  BooksViewModel.swift
//  Peek-a-Book
//
//  Created by Gede Wicaksana on 31/07/21.
//

import Foundation
import RxSwift

class BooksViewModel {
    public let listBook : PublishSubject<Book> = PublishSubject()
    public let error : PublishSubject<String> = PublishSubject()
        
        
        
        
        func getListBook(){
            BookService.getListBook { book in
                if let listbook = book {
                    print(listbook)
                    self.listBook.onNext(listbook)
                }else{
                    print("Data Tidak Ditemukan")
                    self.error.onNext("Data Tidak Ditemukan")
                }
            } failCompletion: { error in
                print(error.errorDescription!)
                self.error.onNext(error.errorDescription ?? "Data Tidak Ditemukan")
            }

        }
}

