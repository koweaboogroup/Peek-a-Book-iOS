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
    
    public let listBook : PublishSubject<[Book]> = PublishSubject()
    public let error : PublishSubject<String> = PublishSubject()
    public let nearestListBook: PublishSubject<[Book]> = PublishSubject()
    
    func getListBook(){
        BookService.getListBook { book in
            print(book)
            self.listBook.onNext(book)
        } failCompletion: { error in
            print(error.errorDescription!)
            self.error.onNext(error.errorDescription ?? "Data Tidak Ditemukan")
        }
    }
    
    func getListBook(yourLocation: CLLocation) {
        BookService.getListBook { book in
            var nearestBook = [Book]()
            for item in book {
                if let lat = item.lat, let long = item.long {
                    let location = CLLocation(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(long))
                    let distance = LocationManager.shared.getDistance(yourLocation: yourLocation, anotherLocation: location)
                    nearestBook.append(Book(id: item.id, bookTitle: item.bookTitle, bookISBN: item.bookISBN, bookWriter: item.bookWriter, bookSinopsis: item.bookSinopsis, bookGenre: item.bookGenre, lenderBook: item.lenderBook, publishedAt: item.publishedAt, createdAt: item.createdAt, updatedAt: item.updatedAt, bookImage: item.bookImage, lat: item.lat, long: item.long, distance: distance))
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

