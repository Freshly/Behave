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

class HomeViewControllerBDDTests: XCTestCase {
    func testLaunchApp_StartScreen_isHomeViewController() {
        let expectations = expectation(description: "Fullfill")
        let api = Behaviour()
        api.listenFor("login-view") {
            api.stubNetworkRequest(stub: Stub(httpMethod: HTTPMethods.post, httpResponse: 200, jsonReturn: "{\"success\":\"true\"}"))
            api.typeIntoTextField(identifier: "email", text: "email")
            api.typeIntoTextField(identifier: "password", text: "password")
            api.tapButton(identifier: "submit")
        }
        api.listenFor("home-view") {
            api.tapRightNavigationItem()
            api.selectTableRow(identfier: "home-view", indexPath: IndexPath(row: 0, section: 0))

        }
        api.listenFor("detail-view") {
            expectations.fulfill()
        }
        api.run(finally: { error in
            if let errorString = error {
                XCTFail(errorString)
            }
        })
        waitForExpectations(timeout: api.testTimeInSeconds)
    }
}
