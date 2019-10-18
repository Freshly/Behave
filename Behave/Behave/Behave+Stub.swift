//
//  Behave+Stub.swift
//  Freshly
//
//  Created by Derek Bronston on 9/27/19.
//  Copyright © 2019 Derek Bronston. All rights reserved.
//

import Foundation
import OHHTTPStubs

extension BehaveV2 {
    
    func stubNetworkRequest(stub: Stub){
        switch stub.httpMethod {
        case .get:
            stubGET(status: stub.httpResponse, json: stub.jsonReturn)
            break
            
        case .post:
            stubPOST(status: stub.httpResponse, json: stub.jsonReturn)
            break
            
        case .patch:
            stubPATCH(status: stub.httpResponse, json: stub.jsonReturn)
            break
            
        case .delete:
            stubDELETE(status: stub.httpResponse, json: stub.jsonReturn)
            break
            
        case .put:
            stubPUT(status: stub.httpResponse, json: stub.jsonReturn)
            break
        }
    }
    
    internal func stubGET(status:Int32,json:String){
        stub(condition: isMethodGET()) { request -> OHHTTPStubsResponse in
            let stubData = json.data(using: String.Encoding.utf8)
            return OHHTTPStubsResponse(data:stubData!, statusCode:status, headers:nil)
        }
    }
    
    internal func stubPATCH(status:Int32,json:String){
        stub(condition: isMethodPATCH()) { request -> OHHTTPStubsResponse in
            let stubData = json.data(using: String.Encoding.utf8)
            return OHHTTPStubsResponse(data:stubData!, statusCode:status, headers:nil)
        }
    }
    
    internal func stubPOST(status:Int32,json:String){
        stub(condition: isMethodPOST()) { request -> OHHTTPStubsResponse in
            let stubData = json.data(using: String.Encoding.utf8)
            return OHHTTPStubsResponse(data:stubData!, statusCode:status, headers:nil)
        }
    }
    
    internal func stubDELETE(status:Int32,json:String){
        stub(condition: isMethodDELETE()) { request -> OHHTTPStubsResponse in
            let stubData = json.data(using: String.Encoding.utf8)
            return OHHTTPStubsResponse(data:stubData!, statusCode:status, headers:nil)
        }
    }
    
    internal func stubPUT(status:Int32,json:String){
        stub(condition: isMethodPUT()) { request -> OHHTTPStubsResponse in
            let stubData = json.data(using: String.Encoding.utf8)
            return OHHTTPStubsResponse(data:stubData!, statusCode:status, headers:nil)
        }
    }
}
