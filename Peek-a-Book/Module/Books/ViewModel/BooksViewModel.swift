//
//  BooksViewModel.swift
//  Peek-a-Book
//
//  Created by Gede Wicaksana on 31/07/21.
//

import Foundation
import RxSwift
import CoreLocation

class BooksViewModel {
    public let error : PublishSubject<String> = PublishSubject()
    public let nearestListBook: PublishSubject<[LenderBook]> = PublishSubject()
    public let listBookNonFiction : PublishSubject<[LenderBook]> = PublishSubject()
    public let listBookFiction : PublishSubject<[LenderBook]> = PublishSubject()
    
    func getListBook(){
        BookService.getListBook { book in
            var fictionBook = [LenderBook]()
            var nonFictionBook = [LenderBook]()
            for item in book {
                if item.book?.bookGenre == 1 {
                    fictionBook.append(LenderBook(id: item.id, price: item.price, bookCondition: item.bookCondition, lender: item.lender, book: item.book, page: item.page, language: item.language, publishedAt: item.publishedAt, createdAt: item.createdAt, updatedAt: item.updatedAt, images: item.images))
                    self.listBookFiction.onNext(fictionBook)
                }
                else if item.book?.bookGenre == 2 {
                    nonFictionBook.append(LenderBook(id: item.id, price: item.price, bookCondition: item.bookCondition, lender: item.lender, book: item.book, page: item.page, language: item.language, publishedAt: item.publishedAt, createdAt: item.createdAt, updatedAt: item.updatedAt, images: item.images))
                    self.listBookNonFiction.onNext(nonFictionBook)
                }
            }
        } failCompletion: { error in
            self.error.onNext(error.errorDescription ?? "Data Tidak Ditemukan")
        }
    }
    
    func getListBook(yourLocation: CLLocation) {
        BookService.getListBook { book in
            var nearestBook = [LenderBook]()
            for item in book {
                if let lat = item.lender?.latitude, let long = item.lender?.longtitude {
                    let location = CLLocation(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(long))
                    let distance = LocationManager.shared.getDistance(yourLocation: yourLocation, anotherLocation: location)
                    
                    nearestBook.append(LenderBook(id: item.id, price: item.price, bookCondition: item.bookCondition, lender: item.lender, book: item.book, page: item.page, language: item.language, publishedAt: item.publishedAt, createdAt: item.createdAt, updatedAt: item.updatedAt, images: item.images, distance: distance))
                }
            }
            nearestBook.sort {
                $0.distance < $1.distance
            }
            self.nearestListBook.onNext(nearestBook)
        } failCompletion: { error in
            self.error.onNext(error.errorDescription ?? "Data Tidak Ditemukan")
        }
        
    }
}

