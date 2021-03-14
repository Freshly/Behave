//
//  Behave+StubTests.swift
//  BehaveTests
//
//  Created by Derek Bronston on 3/14/21.
//  Copyright © 2021 Freshly. All rights reserved.
//
import OHHTTPStubs
import XCTest
@testable import Behave

class Behave_StubTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testStubNetworkRequest_oneRequest() {
        // SET UP
        let sut = Behaviour()
        let stub = Stub(httpResponse: 200, jsonReturn: "value", urlString: "http://domain.com")
        sut.stubNetworkRequest(stub: stub)
        
        // TEST
        fetchData()
    }
    
    func testStubNetworkRequest_multipleRequests() {
        
    }
    
    private func fetchData() {
        let urlString = "http://domain.com"
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, res, error) in
            print("here")
            let r = res as! HTTPURLResponse
            print(r.statusCode)
            
        
        }.resume()
    }
}
