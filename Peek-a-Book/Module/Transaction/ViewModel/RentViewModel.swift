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
    let loading: PublishSubject<Bool> = PublishSubject()
    let error: PublishSubject<String> = PublishSubject()
    let isSuccessChange: PublishSubject<Bool> = PublishSubject()
    let showDatePicker : PublishSubject<Bool> = PublishSubject()
    let selectedId: PublishSubject<Int> = PublishSubject()
    let selectedStatus: PublishSubject<Int> = PublishSubject()
    
    func getListRentAsUser(id: Int){
        loading.onNext(true)
        RentService.getListRenterTransaction(id: id) { rentResponse in
            self.loading.onNext(false)
            var rentObj = [Rent]()
            for item in rentResponse {
                rentObj.append(Rent(id: item.id, periodOfTime: item.periodOfTime, shippingMethods: item.shippingMethods, status: item.status, user: item.user, alamat: item.alamat, provinsi: item.provinsi, kota: item.kota, kelurahan: item.kelurahan, kecamatan: item.kecamatan, longtitude: item.longtitude, latitude: item.latitude, publishedAt: item.publishedAt, createdAt: item.createdAt, updatedAt: item.updatedAt, lenderBooks: item.lenderBooks, name: item.name, bio: item.bio, isFromRenter: true))
            }
            self.ordersForRenter.onNext(rentObj)
        } failCompletion: { error in
            self.loading.onNext(false)
            self.error.onNext(error.errorDescription!)
        }
    }
    
    func getListRentAsLender(id: Int){
        self.loading.onNext(true)
        RentService.getListLenderTransaction(id: id) { rentResponse in
            self.loading.onNext(false)
            var rentObj = [Rent]()
            for item in rentResponse {
                rentObj.append(Rent(id: item.id, periodOfTime: item.periodOfTime, shippingMethods: item.shippingMethods, status: item.status, user: item.user, alamat: item.alamat, provinsi: item.provinsi, kota: item.kota, kelurahan: item.kelurahan, kecamatan: item.kecamatan, longtitude: item.longtitude, latitude: item.latitude, publishedAt: item.publishedAt, createdAt: item.createdAt, updatedAt: item.updatedAt, lenderBooks: item.lenderBooks, name: item.name, bio: item.bio, isFromRenter: false))
            }
            self.ordersForLender.onNext(rentObj)
        } failCompletion: { error in
            self.loading.onNext(false)
            self.error.onNext(error.errorDescription!)
        }
    }
    
    func changeStatus(id: Int, statusRent: Int) {
        self.loading.onNext(true)
        RentService.changeStatus(idRent: id, statusRent: statusRent) { rentResponse in
            self.loading.onNext(false)
            self.isSuccessChange.onNext(true)
        } failCompletion: { error in
            self.loading.onNext(false)
            self.isSuccessChange.onNext(false)
        }
    }
    
    func getFilteredRentsForRenter(statusId: Int){
        loading.onNext(true)
        RentService.getListRenterTransaction(id: DataManager.shared.getUserIdByJwt()) { rentResponse in
            self.loading.onNext(false)
            var rentObj = [Rent]()
            for item in rentResponse {
                if statusId == 1 {
                    rentObj.append(Rent(id: item.id, periodOfTime: item.periodOfTime, shippingMethods: item.shippingMethods, status: item.status, user: item.user, alamat: item.alamat, provinsi: item.provinsi, kota: item.kota, kelurahan: item.kelurahan, kecamatan: item.kecamatan, longtitude: item.longtitude, latitude: item.latitude, publishedAt: item.publishedAt, createdAt: item.createdAt, updatedAt: item.updatedAt, lenderBooks: item.lenderBooks, name: item.name, bio: item.bio, isFromRenter: true))
                } else if statusId == 2 {
                    if item.status?.id == 9 {
                        rentObj.append(Rent(id: item.id, periodOfTime: item.periodOfTime, shippingMethods: item.shippingMethods, status: item.status, user: item.user, alamat: item.alamat, provinsi: item.provinsi, kota: item.kota, kelurahan: item.kelurahan, kecamatan: item.kecamatan, longtitude: item.longtitude, latitude: item.latitude, publishedAt: item.publishedAt, createdAt: item.createdAt, updatedAt: item.updatedAt, lenderBooks: item.lenderBooks, name: item.name, bio: item.bio, isFromRenter: true))
                    }
                } else {
                    if item.status?.id == statusId {
                        rentObj.append(Rent(id: item.id, periodOfTime: item.periodOfTime, shippingMethods: item.shippingMethods, status: item.status, user: item.user, alamat: item.alamat, provinsi: item.provinsi, kota: item.kota, kelurahan: item.kelurahan, kecamatan: item.kecamatan, longtitude: item.longtitude, latitude: item.latitude, publishedAt: item.publishedAt, createdAt: item.createdAt, updatedAt: item.updatedAt, lenderBooks: item.lenderBooks, name: item.name, bio: item.bio, isFromRenter: true))
                    }
                }
            }
            self.ordersForRenter.onNext(rentObj)
        } failCompletion: { error in
            self.loading.onNext(false)
            self.error.onNext(error.errorDescription!)
        }
    }
    
    func getFilteredRentsForLender(statusId: Int){
        loading.onNext(true)
        RentService.getListRenterTransaction(id: DataManager.shared.getLenderId()) { rentResponse in
            self.loading.onNext(false)
            var rentObj = [Rent]()
            for item in rentResponse {
                if statusId == 1 {
                    rentObj.append(Rent(id: item.id, periodOfTime: item.periodOfTime, shippingMethods: item.shippingMethods, status: item.status, user: item.user, alamat: item.alamat, provinsi: item.provinsi, kota: item.kota, kelurahan: item.kelurahan, kecamatan: item.kecamatan, longtitude: item.longtitude, latitude: item.latitude, publishedAt: item.publishedAt, createdAt: item.createdAt, updatedAt: item.updatedAt, lenderBooks: item.lenderBooks, name: item.name, bio: item.bio, isFromRenter: false))
                } else if statusId == 2 {
                    if item.status?.id == 9 {
                        rentObj.append(Rent(id: item.id, periodOfTime: item.periodOfTime, shippingMethods: item.shippingMethods, status: item.status, user: item.user, alamat: item.alamat, provinsi: item.provinsi, kota: item.kota, kelurahan: item.kelurahan, kecamatan: item.kecamatan, longtitude: item.longtitude, latitude: item.latitude, publishedAt: item.publishedAt, createdAt: item.createdAt, updatedAt: item.updatedAt, lenderBooks: item.lenderBooks, name: item.name, bio: item.bio, isFromRenter: false))
                    }
                } else {
                    if item.status?.id == statusId {
                        rentObj.append(Rent(id: item.id, periodOfTime: item.periodOfTime, shippingMethods: item.shippingMethods, status: item.status, user: item.user, alamat: item.alamat, provinsi: item.provinsi, kota: item.kota, kelurahan: item.kelurahan, kecamatan: item.kecamatan, longtitude: item.longtitude, latitude: item.latitude, publishedAt: item.publishedAt, createdAt: item.createdAt, updatedAt: item.updatedAt, lenderBooks: item.lenderBooks, name: item.name, bio: item.bio, isFromRenter: false))
                    }
                }
            }
            self.ordersForLender.onNext(rentObj)
        } failCompletion: { error in
            self.loading.onNext(false)
            self.error.onNext(error.errorDescription!)
        }

    }
}
