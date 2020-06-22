//
//  ExampleAppTests.swift
//  ExampleAppTests
//
//  Created by Denis Efimov on 6/22/20.
//  Copyright © 2020 Freshly. All rights reserved.
//

import XCTest
import Behave
@testable import ExampleApp

class ExampleAppTests: XCTestCase {
    func testExample() throws {
        let expectation = self.expectation(description: "\(#function)")
        let api = Behaviour()
        api.listenFor("master-view") {
            expectation.fulfill()
        }
        
        api.run { error in
            if let error = error {
                XCTFail(error)
            }
        }
        waitForExpectations(timeout: 20)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
