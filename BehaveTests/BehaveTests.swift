//
//  BehaveTests.swift
//  BehaveTests
//
//  Created by Vadim Komisarchik on 7/8/20.
//  Copyright © 2020 Freshly. All rights reserved.
//

import XCTest
import OHHTTPStubs
@testable import Behave


class BehaveTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

     func testFake() {
           let five = 4
           XCTAssertEqual(five, 5)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
