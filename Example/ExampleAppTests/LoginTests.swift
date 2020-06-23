//
//  MobileLoginBDDTests.swift
//  MobileTestPRTests
//
//  Created by Derek Bronston on 10/9/19.
//  Copyright © 2019 Freshly. All rights reserved.
//

import Behave
import RxCocoa
import RxSwift
import XCTest

@testable import ExampleApp

class LoginTests: XCTestCase {
    var sut: LoginController!

    func testGivenTheUsersEmailAndPasswordAreEnteredIntoTheLoginFieldsWhenTheUserTapsSubmitAndTheRequestSucceedsThenDisplayHome() {
        let expectations = expectation(description: "Fullfill")
        let api = Behaviour()
        api.listenFor("login-view", completion: {
            api.stubNetworkRequest(stub: Stub(httpMethod: HTTPMethods.post, httpResponse: 200, jsonReturn: "{\"success\":\"true\"}"))
            api.typeIntoTextField(identifier: "email", text: "email")
            api.typeIntoTextField(identifier: "password", text: "password")
            api.tapButton(identifier: "submit")
        })
        api.listenFor("home-view", completion: {
            expectations.fulfill()
        })
        api.run(finally: { error in
            if let errorString = error {
                XCTFail(errorString)
            }
        })
        waitForExpectations(timeout: api.testTimeInSeconds)
    }
}
