//
//  BooksViewModel.swift
//  Peek-a-Book
//
//  Created by Gede Wicaksana on 31/07/21.
//

import Foundation
import RxSwift

class BooksViewModel {
    public let streetName : PublishSubject<String> = PublishSubject()
    public let districtName : PublishSubject<String> = PublishSubject()
    public let cityName : PublishSubject<String> = PublishSubject()
    public let provName : PublishSubject<String> = PublishSubject()
    public let countryName : PublishSubject<String> = PublishSubject()

    public let buttonDonePressed = PublishSubject<Bool>()
}

