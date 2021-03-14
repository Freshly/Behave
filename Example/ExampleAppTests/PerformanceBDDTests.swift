//
//  ExampleAppTests.swift
//  ExampleAppTests
//
//  Created by Denis Efimov on 6/22/20.
//  Copyright © 2020 Freshly. All rights reserved.
//

import Behave
@testable import ExampleApp
import XCTest

class PerformanceBDDTests: XCTestCase {
    private let performanceView = "performance-view"
    private let efficiencyButton = "efficiency-button"
    
    // THIS TESTS AN EFFICIENT TABLE SO IT SHOULD PASS
    func testPerformance_isEfficient() {
        let expectations = expectation(description: "\(#function)")
        let api = Behaviour()
        navgateToThePerformanceScreen(api)
        api.listen(for: performanceView) {
            let indexPath = IndexPath(row: 5, section: 0)
            api.setUpPerformanceTest()
            api.scrollTableTo(indexPath: indexPath, identfier: self.performanceView)
            api.wait(for: indexPath, parent: api.findTable()!, complete: { cell in
                XCTAssert(api.measurePerformance(frames: 5))
                expectations.fulfill()
            })
        }

        api.run(fail: { error in
            XCTFail(error)
        })
        waitForExpectations(timeout: api.testTimeInterval)
    }
    
    // THIS TESTS AN INEFFICIENT TABLE SO IT SHOULD FAIL, IN THIS CASE TO SATISFY TEST IT RETURNS FALSE
    func testPerformance_isInEfficient() {
        let expectations = expectation(description: "\(#function)")
        let api = Behaviour()
        navgateToThePerformanceScreen(api)
        api.listen(for: performanceView) {
            guard let efficiencyButton = api.queryBarButtonItem(identifier: self.efficiencyButton) else {
                XCTFail("Can't find item")
                expectations.fulfill()
                return
            }
            api.tapRightNavigationItem(with: efficiencyButton)
            let indexPath = IndexPath(row: 10, section: 0)
            api.setUpPerformanceTest()
            api.scrollTableTo(indexPath: indexPath, identfier: self.performanceView)
            let table = api.findTable()!
            let cell = table.cellForRow(at: indexPath)
            XCTAssertNotNil(cell)
                api.wait(for: indexPath, parent: api.findTable()!, complete: { cell in
                XCTAssertFalse(api.measurePerformance(frames: 10))
                expectations.fulfill()
            })
        }

        api.run(fail: { error in
            XCTFail(error)
        })
        waitForExpectations(timeout: api.testTimeInterval)
    }
    
    private func navgateToThePerformanceScreen(_ api: Behaviour) {
        api.listen(for: "list-view") {
            api.selectTableRow(identfier: "list-view", indexPath: IndexPath(row: 1, section: 0))
        }
    }
}
