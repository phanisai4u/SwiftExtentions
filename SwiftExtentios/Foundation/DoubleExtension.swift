//
//  Double+Extension.swift
//  SwiftExtentios
//
//  Created by Phani on 06/03/17.
//  Copyright © 2017 mobileways. All rights reserved.
//

import Foundation

extension Double {
    /// Rounds the double to decimal places value
    func roundToPlaces(_ places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self*divisor).rounded() / divisor
    }
    
    var formatted:String {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        // you can set the minimum fraction digits to 0
        formatter.minimumFractionDigits = 0
        // and set the maximum fraction digits to 1
        formatter.maximumFractionDigits = 1
        return formatter.string(from: NSNumber(value: self))!
    }
    
    func format(_ f: String) -> String {
        return String(format: "%\(f)f", self)
    }
    
    var cleanValue: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
    
     
}
