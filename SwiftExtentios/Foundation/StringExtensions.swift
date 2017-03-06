//
//  String+Extensions.swift
//  AudioBitts
//
//  Created by Phani on 12/28/15.
//  Copyright © 2015 mobileways. All rights reserved.
//

import UIKit

extension Int{
    var toStr:String?{
        get{
            return String(self)
        }
    }
}
extension Double {
    var toStr:String?{
        get{
            return String(self)
        }
    }
}

extension String {
    
    var toInt:Int?{
        get{
            return Int(self)
        }
    }
    
    var toDouble:Double?{
        get{
            return Double(self)
        }
    }
    
    var toFloat:Float?{
        get{
            return Float(self)
        }
    }
    
   
    
    var toBool:Bool?{
        get{
            return "true" == self ?  true : false
        }
    }
    

    func removeAllHTMlTags() -> String {
       return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression ,range: nil)
    }
    

    func sizeOfString (font: UIFont, constrainedToWidth width: Double) -> CGSize {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6.0

        return NSString(string: self).boundingRect(with: CGSize(width: width, height: DBL_MAX),
            options: NSStringDrawingOptions.usesLineFragmentOrigin,
            attributes: [NSFontAttributeName: font, NSParagraphStyleAttributeName: paragraphStyle],
            context: nil).size
    }
    
    func sizeOfStringwithHight (font: UIFont, constrainedToHeight height: Double) -> CGSize {
        return NSString(string: self).boundingRect(with: CGSize(width: DBL_MAX, height: height),
            options: NSStringDrawingOptions.usesLineFragmentOrigin,
            attributes: [NSFontAttributeName: font],
            context: nil).size
    }
    
    func isEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let range = self.range(of: emailRegEx, options:.regularExpression)
        let result = range != nil ? true : false
        return result
    }
    
    func isMobileNumber() -> Bool {
        let numberRegEx = "^\\d{10}$"
        let range = self.range(of: numberRegEx)
        let result = range != nil ? true : false
        return result
    }
    func dateToMilliseconds(formmat:String)->String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = formmat
        let date1 =  dateformatter.date(from: self)
        if let date = date1 {
             return String(date.timeIntervalSince1970)
        }
        return ""
    }
    
    var parseJSONString: AnyObject? {
        let data = self.data(using: String.Encoding.utf8, allowLossyConversion: false)
        
        if let jsonData = data {
            // Will return an object or nil if JSON decoding fails
            do {
                let content = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers)
                return content as AnyObject?
            } catch _ as NSError {
                return nil
            }
        } else {
            // Lossless conversion of the string was not possible
            return nil
        }
    }
    
    func date(format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        return date
    }
    
   
    
}


