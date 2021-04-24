//
//  AutomatedTests.swift
//  ExampleAppTests
//
//  Created by Derek Bronston on 4/22/21.
//  Copyright © 2021 Freshly. All rights reserved.
//

import XCTest
import Behave
@testable import ExampleApp

class AutomatedTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAutomated()  {
        let expectations = expectation(description: "\(#function)")
        let api = Behaviour()
        api.play(complete: {errors in
            if !errors.isEmpty {
                XCTFail("\(errors)")
            }
            expectations.fulfill()
        })
        waitForExpectations(timeout: 5.0)
    }
}
