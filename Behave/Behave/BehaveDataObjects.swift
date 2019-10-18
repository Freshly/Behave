//
//  BehaveDataObjects.swift
//  Freshly
//
//  Created by Derek Bronston on 9/27/19.
//  Copyright © 2019 Derek Bronston. All rights reserved.
//

import Foundation

enum HTTPMethods: String { // http methods
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

struct Stub {
    let httpMethod: HTTPMethods
    let httpResponse: Int32
    let jsonReturn: String
}

struct BDDEvent {
    let event:BehaveEvent
    var stub: Stub?
    var complete = { () in
        return
    }
}
