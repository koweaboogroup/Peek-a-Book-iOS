//
//  MapsViewModel.swift
//  Peek-a-Book
//
//  Created by Arif Rahman on 28/07/21.
//

import Foundation
import RxSwift
class MapsViewModel {
    public let streetName : PublishSubject<String> = PublishSubject()
    public let districtName : PublishSubject<String> = PublishSubject()
    public let cityName : PublishSubject<String> = PublishSubject()
    public let provName : PublishSubject<String> = PublishSubject()
    public let countryName : PublishSubject<String> = PublishSubject()

    public let buttonDonePressed = PublishSubject<Bool>()
}
