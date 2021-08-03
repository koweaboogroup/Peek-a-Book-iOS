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
    
    func goToLoginViewController() -> LoginViewController {
        let vc = LoginViewController(nibName: XIBConstant.LoginViewController, bundle: nil)
        
        return vc
    }
    
    func goToProfileViewController() -> ProfileViewController {
        let vc = ProfileViewController(nibName: XIBConstant.ProfileVC, bundle: nil)
        
        return vc
    }
}
