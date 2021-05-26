//
//  BehaveDataObjectsTests.swift
//  BehaveTests
//
//  Created by Derek Bronston on 3/13/21.
//  Copyright © 2021 Freshly. All rights reserved.
//

import XCTest
@testable import Behave

class BehaveDataObjectsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testInit() {
        let sut = Stub(httpResponse: 200, jsonReturn: "{\"key\": \"value\"}", urlString: "https://domain.com")
        XCTAssertEqual(sut.httpResponse, 200)
        XCTAssertEqual(sut.jsonReturn, "{\"key\": \"value\"}")
        XCTAssertEqual(sut.urlString, "https://domain.com")
    }
}
