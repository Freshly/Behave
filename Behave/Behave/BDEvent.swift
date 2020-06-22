//
//  BDEvent.swift
//  Behave
//
//  Created by Denis Efimov on 6/22/20.
//  Copyright © 2020 Freshly. All rights reserved.
//

import Foundation

struct BDEvent {
    let identifier: String
    var complete = { () in
    }
}
