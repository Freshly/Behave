//
//  BDEventTests.swift
//  BehaveTests
//
//  Created by Derek Bronston on 3/13/21.
//  Copyright © 2021 Freshly. All rights reserved.
//

import XCTest
@testable import Behave

class BDEventTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testInit() {
        let expectations = expectation(description: "fullfill")
        let sut = BDEvent(identifier: "Hello World", complete: {
            expectations.fulfill()
        })
        XCTAssertEqual(sut.identifier, "Hello World")
        sut.complete()
        waitForExpectations(timeout: 1)
    }
}
