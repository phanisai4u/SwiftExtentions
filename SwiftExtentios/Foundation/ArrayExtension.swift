//
//  ArrayExtension.swift
//  SwiftExtentios
//
//  Created by Phani on 06/03/17.
//  Copyright © 2017 mobileways. All rights reserved.
//

import Foundation

extension Array where Element : Hashable {
    var unique: [Element] {
        return Array(Set(self))
    }
}

