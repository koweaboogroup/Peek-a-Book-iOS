//
//  BooksViewController.swift
//  Peek-a-Book
//
//  Created by Yossan Sandi Rahmadi on 26/07/21.
//

import UIKit
import RxSwift
import RxCocoa
import CoreLocation

class BooksViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var searchView: SearchView!
    @IBOutlet weak var nearestBookCollectionView: UICollectionView!
    @IBOutlet weak var fictionBookCollectionView: UICollectionView!
    @IBOutlet weak var nonFictionBookCollectionView: UICollectionView!
    let viewModel = BooksViewModel()
    let disposeBag = DisposeBag()
    let locationManager = CLLocationManager()
    
    // MARK: LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.getListBook()
        checkLocationServices()
        setupView()
        cellSelectedIndex()
        print("\(DateTime.getTimeStamp())")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showNavigation(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        showNavigation(false)
    }
    
    private func setupView(){
        searchView.hideNavigation(true)
        
        nearestBookCollectionView.register(UINib(nibName: XIBConstant.BooksHomescreenCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: XIBConstant.BooksHomescreenCollectionViewCell)
        
        fictionBookCollectionView.register(UINib(nibName: XIBConstant.BooksHomescreenCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: XIBConstant.BooksHomescreenCollectionViewCell)
        
        nonFictionBookCollectionView.register(UINib(nibName: XIBConstant.BooksHomescreenCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: XIBConstant.BooksHomescreenCollectionViewCell)
        
        viewModel.listBookFiction.bind(to: fictionBookCollectionView.rx.items(cellIdentifier: XIBConstant.BooksHomescreenCollectionViewCell, cellType: BooksHomescreenCollectionViewCell.self)){ (row,book,cell) in
            cell.response = book
        }.disposed(by: disposeBag)
        
        viewModel.listBookNonFiction.bind(to: nonFictionBookCollectionView.rx.items(cellIdentifier: XIBConstant.BooksHomescreenCollectionViewCell, cellType: BooksHomescreenCollectionViewCell.self)){ (row,book,cell) in
            cell.response = book
        }.disposed(by: disposeBag)
        
        viewModel.nearestListBook.bind(to: nearestBookCollectionView.rx.items(cellIdentifier: XIBConstant.BooksHomescreenCollectionViewCell, cellType: BooksHomescreenCollectionViewCell.self)) {  (row,book,cell) in
            cell.response = book
        }.disposed(by: disposeBag)
        
    }
    
    private func cellSelectedIndex(){
        
        nearestBookCollectionView.rx.modelSelected(LenderBook.self)
            .subscribe(onNext: { model in
                let vc = ModuleBuilder.shared.goToDetailBooksViewController()
                vc.hidesBottomBarWhenPushed = true
                vc.id = model.id ?? 0
                self.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)

        fictionBookCollectionView.rx.modelSelected(LenderBook.self)
            .subscribe(onNext: { model in
                let vc = ModuleBuilder.shared.goToDetailBooksViewController()
                vc.hidesBottomBarWhenPushed = true
                vc.id = model.id ?? 0
                self.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)

        nonFictionBookCollectionView.rx.modelSelected(LenderBook.self)
            .subscribe(onNext: { model in
                let vc = ModuleBuilder.shared.goToDetailBooksViewController()
                vc.hidesBottomBarWhenPushed = true
                vc.id = model.id ?? 0
                self.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)


    }
    
    private func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            // the user didn't turn it on
            searchView.labelLocation.text = "Aktifkan Lokasi"
        }
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    private func checkLocationAuthorization() {
        switch locationManager.authorizationStatus {
        case .authorizedWhenInUse:
            if let location = LocationManager.shared.getExposedLocation() {
                LocationManager.shared.getPlace(for: location) { placemark in
                    self.searchView.labelLocation.text = placemark?.locality ?? placemark?.subAdministrativeArea ?? placemark?.administrativeArea ?? "Lokasi Tidak Ditemukan"
                }
                viewModel.getListBook(yourLocation: location)
            }
            break
        case .denied:
            // Show alert
            searchView.labelLocation.text = "Aktifkan Lokasi"
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            // Show alert
            break
        case .authorizedAlways:
            break
        default:
            break
        }
    }
        
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}
