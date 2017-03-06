//
//  NSDataExtension.swift
//  SwiftExtentios
//
//  Created by Phani on 06/03/17.
//  Copyright © 2017 mobileways. All rights reserved.
//

import UIKit

extension Data {
    func JSONObject() -> AnyObject? {
        do {
            let content = try JSONSerialization.jsonObject(with: self as Data, options: JSONSerialization.ReadingOptions.allowFragments)
            return content as AnyObject?
        } catch _ as NSError {
            return nil
        }
    }
    
    var string: String {
        return String(data: self as Data, encoding: String.Encoding.utf8) ?? "Error: Not able to get string from the data."
    }
}


extension NSData {
    func JSONObject() -> AnyObject? {
        do {
            let content = try JSONSerialization.jsonObject(with: self as Data, options: JSONSerialization.ReadingOptions.allowFragments)
            return content as AnyObject?
        } catch _ as NSError {
            return nil
        }
    }
    
    var string: String {
        return String(data: self as Data, encoding: String.Encoding.utf8) ?? "Error: Not able to get string from the data."
    }
}


extension NSArray {
    func JSONString() -> NSString? {
        do {
            let content = try JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.prettyPrinted)
            return String(data: content, encoding: String.Encoding.utf8) as NSString?
        } catch _ as NSError {
            return nil
        }
    }
}
