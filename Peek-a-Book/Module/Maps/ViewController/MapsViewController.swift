//
//  MapsViewController.swift
//  Peek-a-Book
//
//  Created by Arif Rahman on 28/07/21.
//

import UIKit
import MapKit
import CoreLocation
import RxSwift

class MapsViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var addressMapsView: AddressMapsView!
    @IBOutlet weak var mapsView: MKMapView!
    @IBOutlet weak var infoView: UIStackView!
    
    private var mapsViewModel : MapsViewModel?
    private let disposeBag = DisposeBag()
    
    private let locationManager = CLLocationManager()
    
    private var streetName = ""
    private var districtName = ""
    private var cityName = ""
    private var provName = ""
    private var countryName = ""

    func initViewModel(_ viewmodel : MapsViewModel) {
        self.mapsViewModel = viewmodel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMaps()
        setupEventListener()
        checkLocationServices()
    }
    
    private func setupMaps(){
        guard let mapsViewModel = mapsViewModel else { return self.dismiss(animated: true, completion: nil) }
        addressMapsView.initViewModel(mapsViewModel)
        mapsView.delegate = self
        infoView.cornerRadius(10)
    }
    
    private func setupEventListener(){
        mapsViewModel?.buttonDonePressed
            .subscribe(onNext: { pressed in
                if(pressed){
                    self.mapsViewModel?.streetName.onNext(self.streetName)
                    self.mapsViewModel?.districtName.onNext(self.districtName)
                    self.mapsViewModel?.cityName.onNext(self.cityName)
                    self.mapsViewModel?.provName.onNext(self.provName)
                    self.mapsViewModel?.countryName.onNext(self.countryName)
                    self.dismiss(animated: true, completion: nil)
                }
            })
            .disposed(by: disposeBag)
    }
    @IBAction func infoDidTapped(_ sender: Any) {
    }
    
    @IBAction func locationDidTapped(_ sender: Any) {
        if let location = LocationManager.shared.getExposedLocation() {
            followUserLocation(location)
        }
    }
    private func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            // the user didn't turn it on
        }
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    private func checkLocationAuthorization() {
        switch locationManager.authorizationStatus {
        case .authorizedWhenInUse:
            mapsView.showsUserLocation = true
            if let location = LocationManager.shared.getExposedLocation() {
                followUserLocation(location)
            }
            break
        case .denied:
            // Show alert
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
    
    private func followUserLocation(_ location : CLLocation) {
        mapsView.centerToLocation(location)
        LocationManager.shared.getPlace(for: location) { placemark in
            guard let placemark = placemark else { return }
            self.streetName = placemark.thoroughfare ?? "Jalan Tidak Diketahui"
            self.districtName = placemark.locality ?? ""
            self.cityName = placemark.subAdministrativeArea ?? ""
            self.provName = placemark.administrativeArea ?? ""
            self.countryName = placemark.country ?? ""
            
            let location = [self.districtName, self.cityName, self.provName, self.countryName]
            let administrativePlaceName = location.filter { !$0.isEmpty }.joined(separator: ", ")
            
            self.addressMapsView.labelAddress.text = self.streetName
            self.addressMapsView.labelDetailAddress.text = administrativePlaceName
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
    
}

extension MapsViewController: MKMapViewDelegate {
        
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        print(mapView.centerCoordinate)
        let lat = mapsView.centerCoordinate.latitude
        let long = mapView.centerCoordinate.longitude
        let location = CLLocation(latitude: lat, longitude: long)
        followUserLocation(location)
    }
}
