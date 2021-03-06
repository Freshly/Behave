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
    func testPerformance_isEfficientWithPropertyOn() {
        let expectations = expectation(description: "\(#function)")
        let api = Behaviour()
        navigateToThePerformanceScreen(api)
        api.listen(for: performanceView) {
            let indexPath = IndexPath(row: 5, section: 0)
            api.scrollTableTo(indexPath: indexPath, identifier: self.performanceView)
        }
        api.listen(for: "row-4", completion: {
            expectations.fulfill()
        })
        api.run(fail: { error in
            XCTFail(error)
        })
        waitForExpectations(timeout: api.testTimeInterval)
    }
    
    // THIS TESTS AN INEFFICIENT TABLE SO IT SHOULD FAIL, IN THIS CASE TO SATISFY TEST IT RETURNS FALSE
    func testPerformance_isInEfficientWithPropertyOn() {
        let expectations = expectation(description: "\(#function)")
        let api = Behaviour()
        navigateToThePerformanceScreen(api)
        api.listen(for: performanceView) {
            guard let efficiencyButton = api.queryBarButtonItem(identifier: self.efficiencyButton) else {
                XCTFail("Can't find item")
                expectations.fulfill()
                return
            }
            api.tapRightNavigationItem(with: efficiencyButton)
            let indexPath = IndexPath(row: 15, section: 0)
            api.scrollTableTo(indexPath: indexPath, identifier: self.performanceView)
        }
        api.listen(for: "row-15", completion: {
            expectations.fulfill()
        })
        api.run(fail: { error in
            XCTFail(error)
        },warn: { warnings in
            print(warnings)
        })
        waitForExpectations(timeout: api.testTimeInterval)
    }
    
    // THIS TESTS AN INEFFICIENT TABLE BUT PERFORMANCE TESTING IS OFF SO IT SHOULD NOT THROW A WARNING
    func testPerformance_isInEfficientWithPropertyOff() {
        let expectations = expectation(description: "\(#function)")
        let api = Behaviour()
        api.testPerformance = false
        navigateToThePerformanceScreen(api)
        api.listen(for: performanceView) {
            guard let efficiencyButton = api.queryBarButtonItem(identifier: self.efficiencyButton) else {
                XCTFail("Can't find item")
                expectations.fulfill()
                return
            }
            api.tapRightNavigationItem(with: efficiencyButton)
            let indexPath = IndexPath(row: 15, section: 0)
            api.scrollTableTo(indexPath: indexPath, identifier: self.performanceView)
        }
        api.listen(for: "row-15", completion: {
            expectations.fulfill()
        })
        api.run(fail: { error in
            XCTFail(error)
        },warn: { warnings in
            XCTFail()
        })
        waitForExpectations(timeout: api.testTimeInterval)
    }
    
    private func navigateToThePerformanceScreen(_ api: Behaviour) {
        api.listen(for: "list-view") {
            api.selectTableRow(identfier: "list-view", indexPath: IndexPath(row: 1, section: 0))
        }
    }
}
