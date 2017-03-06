//
//  IntExtension.swift
//  SwiftExtentios
//
//  Created by Phani on 06/03/17.
//  Copyright © 2017 mobileways. All rights reserved.
//

import Foundation

extension Int {
    
    func currency(isDollar: Bool = true) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        if isDollar {
            formatter.locale = Locale(identifier: "en_US")
        } else {
            formatter.locale = NSLocale.current
        }
        return formatter.string(from: NSNumber(value: self))!
    }
    
}

extension UInt64 {
    
    func date(isMilliSeconds: Bool = false) -> Date {
        return Date(timeIntervalSince1970: TimeInterval(self))
    }
    
}
