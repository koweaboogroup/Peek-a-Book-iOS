//
//  RentViewModel.swift
//  Peek-a-Book
//
//  Created by Muhammad Rifki Wildadi on 04/08/21.
//

import Foundation
import RxSwift

struct RentViewModel{
    public let ordersForRenter: PublishSubject<[Rent]> = PublishSubject()
    public let ordersForLender: PublishSubject<[Rent]> = PublishSubject()
    let error: PublishSubject<String> = PublishSubject()
    let isSuccessChange: PublishSubject<Bool> = PublishSubject()
    
    func getListRentAsUser(id: Int){
        RentService.getListRenterTransaction(id: id) { rentResponse in
            var rentObj = [Rent]()
            for item in rentResponse {
                rentObj.append(Rent(id: item.id, periodOfTime: item.periodOfTime, shippingMethods: item.shippingMethods, status: item.status, user: item.user, alamat: item.alamat, provinsi: item.provinsi, kota: item.kota, kelurahan: item.kelurahan, kecamatan: item.kecamatan, longtitude: item.longtitude, latitude: item.latitude, publishedAt: item.publishedAt, createdAt: item.createdAt, updatedAt: item.updatedAt, lenderBooks: item.lenderBooks, name: item.name, bio: item.bio, isFromRenter: true))
            }
            self.ordersForRenter.onNext(rentObj)
        } failCompletion: { error in
            self.error.onNext(error.errorDescription!)
        }
    }

    func getListRentAsLender(id: Int){
        RentService.getListLenderTransaction(id: id) { rentResponse in
            var rentObj = [Rent]()
            for item in rentResponse {
                rentObj.append(Rent(id: item.id, periodOfTime: item.periodOfTime, shippingMethods: item.shippingMethods, status: item.status, user: item.user, alamat: item.alamat, provinsi: item.provinsi, kota: item.kota, kelurahan: item.kelurahan, kecamatan: item.kecamatan, longtitude: item.longtitude, latitude: item.latitude, publishedAt: item.publishedAt, createdAt: item.createdAt, updatedAt: item.updatedAt, lenderBooks: item.lenderBooks, name: item.name, bio: item.bio, isFromRenter: false))
            }
            self.ordersForLender.onNext(rentObj)
        } failCompletion: { error in
            self.error.onNext(error.errorDescription!)
        }
    }
    
    func changeStatus(id: Int, statusRent: Int) {
        RentService.changeStatus(idRent: id, statusRent: statusRent) { rentResponse in
            self.isSuccessChange.onNext(true)
        } failCompletion: { error in
            self.isSuccessChange.onNext(false)
        }

    }
    
}
