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
    private let homeView = "home-view"
    private let detailView = "detail-view"
    private let addButton = "add-button"
    private let editButton = "edit-button"
    
    func testPerformance_isInEfficient() {
        let expectations = expectation(description: "\(#function)")
        let api = Behaviour()
        navgateToTheHomeScreen(api)
        api.listen(for: homeView) {
            let indexPath = IndexPath(row: 5, section: 0)
            api.setUpPerformanceTest()
            api.scrollTableTo(indexPath: indexPath, identfier: self.homeView)
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
    
    func testPerformance_isEfficient() {
        let expectations = expectation(description: "\(#function)")
        let api = Behaviour()
        navgateToTheHomeScreen(api)
        api.listen(for: homeView) {
            guard let addButton = api.queryBarButtonItem(identifier: self.addButton) else {
                XCTFail("Can't find item")
                expectations.fulfill()
                return
            }
            api.tapRightNavigationItem(with: addButton)
            let indexPath = IndexPath(row: 10, section: 0)
            api.setUpPerformanceTest()
            api.scrollTableTo(indexPath: indexPath, identfier: self.homeView)
            let table = api.findTable()!
            let cell = table.cellForRow(at: indexPath)
            XCTAssertNotNil(cell)
                api.wait(for: indexPath, parent: api.findTable()!, complete: { cell in
                XCTAssert(api.measurePerformance(frames: 10))
                expectations.fulfill()
            })
        }

        api.run(fail: { error in
            XCTFail(error)
        })
        waitForExpectations(timeout: api.testTimeInterval)
    }
    
    private func navgateToTheHomeScreen(_ api: Behaviour) {
        api.listen(for: "login-view") {
            api.stubNetworkRequest(stub: Stub(httpResponse: 200, jsonReturn: "{\"success\":\"true\"}", urlString: URLS.login.rawValue))
            api.stubNetworkRequest(stub: Stub(httpResponse: 200, jsonReturn: "{\"success\":\"true\"}", urlString: URLS.data.rawValue))
            api.typeIntoTextField(identifier: "email", text: "email")
            api.typeIntoTextField(identifier: "password", text: "password")
            api.tapButton(identifier: "submit")
        }
    }
}
