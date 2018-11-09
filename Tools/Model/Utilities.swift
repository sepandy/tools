//
//  Utility.swift
//  
//
//  Created by Sepand Yadollahifar on 9/20/18.
//  Copyright © 2018 3p. All rights reserved.
//

import Foundation

class Utility {
    
    static func addComma(To priceTag: String) -> String {
        
        var edited = priceTag
        
        
        if let priceInt = Int(priceTag) {
            
            let price = NSNumber(value: priceInt)
            
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            
            formatter.locale = Locale(identifier: "fa_IR")
            edited = formatter.string(from: price)! // $123"
        }
        
        return edited
        
    }
    
    static func convert(string: String ) -> NSNumber? {
        
        let Formatter = NumberFormatter()
        Formatter.locale = NSLocale(localeIdentifier: "EN") as Locale?
        let final = Formatter.number(from: string)
        
        if let num = final {
            
            if num != 0 {
                
                return final
            }
        }
        
        return nil
    }
    
    static func returnDate(from timestamp: String) -> String {
        
        if let stringToInt = Int(timestamp) {
            
            let dateString = Date(timeIntervalSince1970: TimeInterval.init(exactly: stringToInt)!).description(with: Locale(identifier: "fa_IR"))
            return dateString
        }
        return "error"
    }
    
    
    static func verify(phoneNumber: String) -> Bool {
        
        
        return true
    }
    
    static func returnDate(from timestamp: Int) -> String {
        
        let dateString = Date(timeIntervalSince1970: TimeInterval.init(exactly: timestamp)!).description(with: Locale(identifier: "fa_IR"))
        return dateString
    }
    
    static func convertToPersianNumberFrom(English number: String) -> String? {
        
        let numbersDictionary : Dictionary = ["0" : "۰","1" : "۱", "2" : "۲", "3" : "۳", "4" : "۴", "5" : "۵", "6" : "۶", "7" : "۷", "8" : "۸", "9" : "۹"]
        var str : String = number
        
        for (key,value) in numbersDictionary {
            str =  str.replacingOccurrences(of: key, with: value)
        }
        
        return str
    }
}
