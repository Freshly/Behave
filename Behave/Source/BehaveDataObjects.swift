//
//  BehaveDataObjects.swift
//  Freshly
//
//  Created by Derek Bronston on 9/27/19.
//  Copyright © 2019 Derek Bronston. All rights reserved.
//

import Foundation

public enum HTTPMethods: String { // http methods
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

public struct Stub {
    public let httpMethod: HTTPMethods
    public let httpResponse: Int32
    public let jsonReturn: String
    public let urlString: String

    public init(httpMethod: HTTPMethods = HTTPMethods.get, httpResponse: Int32, jsonReturn: String, urlString:String) {
        self.httpMethod = httpMethod
        self.httpResponse = httpResponse
        self.jsonReturn = jsonReturn
        self.urlString = urlString
    }
}
