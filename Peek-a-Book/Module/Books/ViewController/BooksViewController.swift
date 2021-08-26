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

class BooksViewController: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate {
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBOutlet weak var searchView: SearchView!
    @IBOutlet weak var nearestBookCollectionView: UICollectionView!
    @IBOutlet weak var fictionBookCollectionView: UICollectionView!
    @IBOutlet weak var nonFictionBookCollectionView: UICollectionView!
    
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var emptyNearestView: ErrorStateView!
    let viewModel = BooksViewModel()
    let disposeBag = DisposeBag()
    let locationManager = CLLocationManager()
    
    // MARK: LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        viewModel.getListBook()
        checkLocationServices()
        cellSelectedIndex()
        print("\(DateTime.getTimeStamp())")
        setupListener()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showNavigation(true)
    }
    
    @IBAction func locationButtonTapped(_ sender: UIButton) {
        ConfirmationDialog.showAlertPositive(viewController: self, title: "Aktifkan GPS", subtitle: "Mohon mengaktifkan GPS agar kami bisa memberikan rekomendasi buku yang ada di dekatmu", positiveText: "Aktifkan", negativeText: "Tolak") {
            if let bundleId = Bundle.main.bundleIdentifier, let url = URL(string: "\(UIApplication.openSettingsURLString)&path=LOCATION/\(bundleId)") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            self.dismiss(animated: true, completion: nil)
        } negativeCompletion: {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func seeAllFictionTapped(_ sender: UIButton) {
        let vc = ModuleBuilder.shared.goToSearchViewController()
        vc.hidesBottomBarWhenPushed = true
        vc.setQuery(query: "", isFiction: true)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func seeAllNonFictionTapped(_ sender: UIButton) {
        let vc = ModuleBuilder.shared.goToSearchViewController()
        vc.hidesBottomBarWhenPushed = true
        vc.setQuery(query: "", isFiction: false)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        showNavigation(false)
    }
    
    private func setupView() {
        viewModel.loading.asObserver().map{ item in
            !item
        }.bind(to: loadingView.rx.isHidden)
            .disposed(by: disposeBag)

        viewModel.loading.asObserver()
            .bind(to: loadingView.rx.isAnimating)
            .disposed(by: disposeBag)

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
        
        viewModel.nearestListBook.asObserver().map { item in
            !item.isEmpty
        }.bind(to: emptyNearestView.rx.isHidden)
        .disposed(by: disposeBag)

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
            isLocationEnabled(false)
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
            isLocationEnabled(true)
            break
        case .denied:
            // Show alert
            searchView.labelLocation.text = "Aktifkan Lokasi"
            isLocationEnabled(false)
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            isLocationEnabled(false)
            break
        case .restricted:
            // Show alert
            isLocationEnabled(false)
            break
        case .authorizedAlways:
            isLocationEnabled(true)
            break
        default:
            isLocationEnabled(false)
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
    
    private func setupListener(){
        searchView.searchField.addTarget(self, action: #selector(textFieldDidChange), for: .editingDidEndOnExit)
    }
    
    @objc func textFieldDidChange(){
        let vc = ModuleBuilder.shared.goToSearchViewController()
        vc.setQuery(query: searchView.searchField.text!)
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
        searchView.searchField.text = ""
    }
    
    private func isLocationEnabled(_ isEnabled: Bool){
        locationButton.isHidden = isEnabled
        emptyNearestView.isHidden = isEnabled
        nearestBookCollectionView.isHidden = !isEnabled
    }
}
