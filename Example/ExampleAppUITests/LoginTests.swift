//
//  MobileTestPRUITests.swift
//  MobileTestPRUITests
//
//  Created by Derek Bronston on 12/18/18.
//  Copyright © 2018 Freshly. All rights reserved.
//

import XCTest
// import OHHTTPStubs

class LoginTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {}

    func testGivenUserCredsWhenTheUserTapsSubmitAndTheRequestSucceedsThenDisplayHome() {
        let app = XCUIApplication()
        app.launchArguments = ["ui-tests", "login-success", "{\"success\":true}"]
        app.launch()
        app.textFields["email"].tap()
        app.textFields["email"].typeText("email@test.com")
        app.textFields["password-field"].tap()
        app.textFields["password-field"].typeText("password")
        app.buttons["submit"].tap()

        // BACK BUTTON
        XCTAssert(app.navigationBars.staticTexts["Home"].exists)
    }
}
