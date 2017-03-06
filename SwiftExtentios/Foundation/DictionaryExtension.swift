//
//  DictionaryExtension.swift
//  SwiftExtentios
//
//  Created by Phani on 06/03/17.
//  Copyright © 2017 mobileways. All rights reserved.
//

import Foundation

extension Dictionary {
    func JSONString() -> String? {
        do {
            let content = try JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.prettyPrinted)
            var string = String(data: content, encoding: String.Encoding.utf8) as String?
            string = string?.replacingOccurrences(of: "\\", with: "")
            return string
        } catch _ as NSError {
            return nil
        }
    }
    
    mutating func update(other:Dictionary) {
        for (key,value) in other {
            self.updateValue(value, forKey:key)
        }
    }
}

extension Dictionary where Value: Equatable {
    func keyFor(value: Value) -> Key? {
        guard let index = index(where: { $0.1 == value }) else {
            return nil
        }
        return self[index].0
    }
}
