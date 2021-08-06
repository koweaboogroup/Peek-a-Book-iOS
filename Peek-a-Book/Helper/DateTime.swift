//
//  DateTime.swift
//  Peek-a-Book
//
//  Created by Gede Wicaksana on 05/08/21.
//

import Foundation
class DateTime{
    static func getTimeStamp() -> String{
        let date = Date()
        let formatter = DateFormatter()
        let result = formatter.string(from: date)
    
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return result
    }
    
    
}
