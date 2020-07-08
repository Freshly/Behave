//
//  BehaveDataObjects.swift
//  Freshly
//
//  Created by Derek Bronston on 9/27/19.
//  Copyright © 2019 Derek Bronston. All rights reserved.
//

import Foundation

public struct Stub {
    public let httpResponse: Int32
    public let jsonReturn: String
    public let urlString: String

    public init(httpResponse: Int32, jsonReturn: String, urlString:String) {
        self.httpResponse = httpResponse
        self.jsonReturn = jsonReturn
        self.urlString = urlString
    }
}
