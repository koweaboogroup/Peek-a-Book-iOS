//
//  String+Validation.swift
//  Peek-a-Book
//
//  Created by Yossan Sandi Rahmadi on 04/08/21.
//

import Foundation

extension String {
    enum ValidityType {
        case email
        case phoneNumber
        case password
    }
    
    enum Regex: String {
        case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z.]{2,64}"
        case phoneNumber = #"^(\+62|62|0)8[1-9][0-9]{6,9}"#
        case password = #"^(?=.*\d)(?=.*[a-zA-Z]).{6,32}"#
    }
    
    func isValid (_ validityType: ValidityType) -> Bool {
        let format = "SELF MATCHES %@"
        var regex = ""
        
        switch validityType {
        case .email:
            regex = Regex.email.rawValue
        case .phoneNumber:
            regex = Regex.phoneNumber.rawValue
        case .password:
            regex = Regex.password.rawValue
        }
        
        return NSPredicate(format: format, regex).evaluate(with: self)
    }
}
