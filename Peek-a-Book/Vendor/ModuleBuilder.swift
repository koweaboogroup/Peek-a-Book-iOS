//
//  ModuleBuilder.swift
//  Peek-a-Book
//
//  Created by Yossan Sandi Rahmadi on 02/08/21.
//

import UIKit

class ModuleBuilder {
    static let shared = ModuleBuilder()
    
    func goToBooksViewController() -> BooksViewController {
        let vc = BooksViewController(nibName: XIBConstant.BooksVC, bundle: nil)
        
        return vc
    }
    
    func goToDetailBooksViewController() -> DetailBooksViewController {
        let vc = DetailBooksViewController(nibName: XIBConstant.DetailBooksVC, bundle: nil)
        
        return vc
    }
    
    func goToLoginViewController() -> LoginViewController {
        let vc = LoginViewController(nibName: XIBConstant.LoginViewController, bundle: nil)
        
        return vc
    }
    
    func goToProfileViewController() -> ProfileViewController {
        let vc = ProfileViewController(nibName: XIBConstant.ProfileVC, bundle: nil)
        
        return vc
    }
    
    func goToRegisterViewController() -> RegisterViewController {
        let vc = RegisterViewController(nibName: XIBConstant.RegisterViewController, bundle: nil)
        
        return vc
    }

    func goToAlamatViewController() -> AddressSettingViewController {
        let vc = AddressSettingViewController(nibName: XIBConstant.AddressSettingViewController, bundle: nil)
        
        return vc
    }

    func goToMapsViewController() -> MapsViewController {
        let vc = MapsViewController(nibName: XIBConstant.MapsVC, bundle: nil)
        
        return vc
    }
    
    func goToEditProfileViewController() -> EditProfileViewController {
        let vc = EditProfileViewController(nibName: XIBConstant.EditProfileViewController, bundle: nil)
        
        return vc
    }

    func goToRegisterLenderViewController() -> RegisterLenderViewController {
        let vc = RegisterLenderViewController(nibName: XIBConstant.RegisterLenderViewController, bundle: nil)
        
        return vc
    }

    func goToProfileLenderViewController() -> ProfileLenderViewController {
        let vc = ProfileLenderViewController(nibName: XIBConstant.ProfileTokoViewController, bundle: nil)
        
        return vc
    }
    
    func goToEditProfileLenderViewController() -> EditProfileLenderViewController {
        let vc = EditProfileLenderViewController(nibName: XIBConstant.EditProfileLenderViewController, bundle: nil)
        
        return vc
    }
    
    func goToCheckOutViewController() -> CheckOutViewController {
        let vc = CheckOutViewController(nibName: XIBConstant.CheckOutViewController, bundle: nil)
        
        return vc
    }

    func goToTransactionViewController() -> TransactionViewController {
        let vc = TransactionViewController(nibName: XIBConstant.TransactionViewController, bundle: nil)
        
        return vc
    }
    
    func goToDetailOrderViewController() -> DetailOrderViewController {
        let vc = DetailOrderViewController(nibName: XIBConstant.DetailOrderVC, bundle: nil)
        
        return vc
    }

}
