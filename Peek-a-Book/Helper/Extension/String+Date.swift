//
//  String+Date.swift
//  Peek-a-Book
//
//  Created by Arif Rahman on 23/08/21.
//

import Foundation
extension String {
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let date = dateFormatter.date(from:self)
        return date
    }
}

extension Date {
    func toString( dateFormat format: String, toFormat outputFormat: String ) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let dateString = dateFormatter.string(from: self)
        
        if let newDate = dateFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = outputFormat
            outputFormatter.locale = Locale(identifier: "id_ID")
            return outputFormatter.string(from: newDate)
        }else{
            return ""
        }
    }
}
