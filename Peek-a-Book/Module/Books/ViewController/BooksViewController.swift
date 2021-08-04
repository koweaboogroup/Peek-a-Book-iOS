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
    let viewModel = BooksViewModel()
    let disposeBag = DisposeBag()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getListBook()
        checkLocationServices()
        setupView()
    }
    
    private func setupView(){
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 168, height: 299)
        flowLayout.minimumLineSpacing = 5.0
        flowLayout.minimumInteritemSpacing = 5.0
        
        nearestBookCollectionView.register(UINib(nibName: XIBConstant.BooksHomescreenCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: XIBConstant.BooksHomescreenCollectionViewCell)

        nearestBookCollectionView.collectionViewLayout = flowLayout
        self.nearestBookCollectionView.showsHorizontalScrollIndicator = false

        viewModel.nearestListBook.bind(to: nearestBookCollectionView.rx.items(cellIdentifier: XIBConstant.BooksHomescreenCollectionViewCell, cellType: BooksHomescreenCollectionViewCell.self)) {  (row,book,cell) in
            cell.response = book
        }.disposed(by: disposeBag)
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
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
