//
//  BehaveConstants.swift
//  Freshly
//
//  Created by Derek Bronston on 9/11/19.
//  Copyright © 2019 Derek Bronston. All rights reserved.
//

import Foundation

struct BehaveEvent: RawRepresentable {
    typealias RawValue = String
    var rawValue: String
    
    init(_ rawValue: RawValue) {
        self.rawValue = rawValue
    }
    
    init?(rawValue: RawValue) {
        self.rawValue = rawValue
    }
}

