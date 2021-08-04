//
//  BooksViewController.swift
//  Peek-a-Book
//
//  Created by Yossan Sandi Rahmadi on 26/07/21.
//

import UIKit
import RxSwift
import CoreLocation

class BooksViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var searchView: SearchView!
    let mapsViewModel = MapsViewModel()
    let disposeBag = DisposeBag()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewModel = BooksViewModel()
        viewModel.getListBook()
        
        checkLocationServices()
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
            searchView.labelLokasi.text = "Aktifkan Lokasi"
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
                    self.searchView.labelLokasi.text = placemark?.locality ?? placemark?.subAdministrativeArea ?? placemark?.administrativeArea ?? "Lokasi Tidak Ditemukan"
                }
            }
            break
        case .denied:
            // Show alert
            searchView.labelLokasi.text = "Aktifkan Lokasi"
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
