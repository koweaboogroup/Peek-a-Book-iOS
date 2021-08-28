//
//  ProfileViewController.swift
//  Peek-a-Book
//
//  Created by Yossan Sandi Rahmadi on 26/07/21.
//

import UIKit
import RxSwift
import RxCocoa
import SafariServices

class ProfileViewController: UIViewController {
    // MARK: -Deklarasi IBOutlet
    @IBOutlet weak var profileImage: CircleImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    private var disposeBag = DisposeBag()
    
    private var userObj = User()
    
    private var profileViewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setupView()
        fetchProfile()
    }
    
    func setNavigationBar(){
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "DM Serif Text", size: 19)!]
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "bell.fill"), style: .done, target: self, action: #selector(notificationTapped))
        
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "DM Serif Text", size: 19.0)!], for: .normal)
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
    @objc private func notificationTapped(_ sender: UINavigationItem){
        print("to notification")
    }
    
    private func fetchProfile(){
        profileViewModel.fetchProfile()
    }
    
    private func setupView(){
        profileViewModel.loading.asObserver()
            .bind(to: loadingView.rx.isAnimating)
            .disposed(by: disposeBag)
        
        profileViewModel.loading.asObserver().map{ item in
            !item
        }.bind(to: loadingView.rx.isHidden)
            .disposed(by: disposeBag)
        
        profileImage.setPlaceHolderImage(image: UIImage(systemName: "person.fill")!)
        profileImage.setBackgroundColor(color: #colorLiteral(red: 0.9058823529, green: 0.9568627451, blue: 1, alpha: 1))
        profileViewModel.user.subscribe(onNext: { user in
            self.userObj = user
        }).disposed(by: disposeBag)
        profileViewModel.user
            .asObserver()
            .map { user in
                user.username
            }
            .bind(to: profileNameLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showNavigation(true)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        showNavigation(false)
        self.title = ""
    }
    
    // MARK: -Deklarasi Action Button
    @IBAction func editProfileButtonPressed(_ sender: UIButton) {
        let vc = ModuleBuilder.shared.goToEditProfileViewController()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func rentHistoryTapped(_ sender: UITapGestureRecognizer) {
        let vc = ModuleBuilder.shared.goToTransactionViewController()
        vc.hidesBottomBarWhenPushed = true
        vc.setUserID(id: DataManager.shared.getUserIdByJwt())
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func startRentTapped(_ sender: UITapGestureRecognizer) {
        if userObj.lender != nil {
            let vc = ModuleBuilder.shared.goToProfileLenderViewController()
            vc.hidesBottomBarWhenPushed = true
            vc.setLenderId(id: userObj.lender?.id ?? 0)
            vc.setUserPenyewa(flag: false)
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = ModuleBuilder.shared.goToRegisterLenderViewController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func tncTapped(_ sender: UITapGestureRecognizer) {
        let safariViewController = SFSafariViewController(url: URL(string: Constant.termsAndConditionsLink) ?? URL(fileURLWithPath: ""))
        
        self.present(safariViewController, animated: true, completion: nil)
    }
    
    @IBAction func logoutTapped(_ sender: UITapGestureRecognizer) {
        profileViewModel.logout()
        let vc = ModuleBuilder.shared.goToLoginViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
