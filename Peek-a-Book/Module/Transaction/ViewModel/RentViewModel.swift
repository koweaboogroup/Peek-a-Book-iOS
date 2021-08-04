//
//  RentViewModel.swift
//  Peek-a-Book
//
//  Created by Muhammad Rifki Wildadi on 04/08/21.
//

import Foundation
import RxSwift

struct RentViewModel{
    public let rent: PublishSubject<[RentResponse]> = PublishSubject()
}
