//
//  Behave+Stub.swift
//  Freshly
//
//  Created by Derek Bronston on 9/27/19.
//  Copyright © 2019 Derek Bronston. All rights reserved.
//

import Foundation
import OHHTTPStubs

extension Behaviour {
    public func stubNetworkRequest(stub: Stub) {
        switch stub.httpMethod {
        case .get:
            stubGET(status: stub.httpResponse, json: stub.jsonReturn)

        case .post:
            stubPOST(status: stub.httpResponse, json: stub.jsonReturn)

        case .patch:
            stubPATCH(status: stub.httpResponse, json: stub.jsonReturn)

        case .delete:
            stubDELETE(status: stub.httpResponse, json: stub.jsonReturn)

        case .put:
            stubPUT(status: stub.httpResponse, json: stub.jsonReturn)
        }
    }

    internal func stubGET(status: Int32, json: String) {
        stub(condition: isMethodGET()) { _ -> HTTPStubsResponse in
            let stubData = json.data(using: String.Encoding.utf8)
            return HTTPStubsResponse(data: stubData!, statusCode: status, headers: nil)
        }
    }

    internal func stubPATCH(status: Int32, json: String) {
        stub(condition: isMethodPATCH()) { _ -> HTTPStubsResponse in
            let stubData = json.data(using: String.Encoding.utf8)
            return HTTPStubsResponse(data: stubData!, statusCode: status, headers: nil)
        }
    }

    internal func stubPOST(status: Int32, json: String) {
        stub(condition: isMethodPOST()) { _ -> HTTPStubsResponse in
            let stubData = json.data(using: String.Encoding.utf8)
            return HTTPStubsResponse(data: stubData!, statusCode: status, headers: nil)
        }
    }

    internal func stubDELETE(status: Int32, json: String) {
        stub(condition: isMethodDELETE()) { _ -> HTTPStubsResponse in
            let stubData = json.data(using: String.Encoding.utf8)
            return HTTPStubsResponse(data: stubData!, statusCode: status, headers: nil)
        }
    }

    internal func stubPUT(status: Int32, json: String) {
        stub(condition: isMethodPUT()) { _ -> HTTPStubsResponse in
            let stubData = json.data(using: String.Encoding.utf8)
            return HTTPStubsResponse(data: stubData!, statusCode: status, headers: nil)
        }
    }

    /**
     READ DATA FILE INTO STRING

     - parameter: urlString:String
     - return: String?
     */
    public func openFileAndReadIntoString(urlString: String) -> String? {
        if let dir = Bundle.main.path(forResource: urlString, ofType: "json") {
            do {
                let text2 = try String(contentsOfFile: dir)
                return text2
            } catch _ as NSError {
                return nil
            }
        }
        return nil
    }
}
