//
//  MobileLoginBDDTests.swift
//  MobileTestPRTests
//
//  Created by Derek Bronston on 10/9/19.
//  Copyright © 2019 Freshly. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa
import Behave

@testable import ExampleApp

class MobileLoginBDDTests:XCTestCase {
    
    var sut: LoginController!
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    //MOB-2161
    func testGivenTheUsersEmailAndPasswordAreEnteredIntoTheLoginFieldsWhenTheUserTapsSubmitAndTheRequestSucceedsThenDisplayHome(){
        
        let expectations = expectation(description: "Fullfill")
        let api = Behaviour()
        api.listenFor("login-view" , completion: {
            api.stubNetworkRequest(stub: Stub(httpMethod: HTTPMethods.post, httpResponse: 200, jsonReturn: "{\"success\":\"true\"}"))
            api.typeIntoTextField(identifier: "email", text: "email")
            api.typeIntoTextField(identifier: "password", text: "password")
            api.tapButton(identifier: "submit")
        })
        api.listenFor("home-view", completion: {
            expectations.fulfill()
        })
        api.run(finally: { (error) in
            if let errorString = error {
                XCTFail(errorString)
            }
        })
        waitForExpectations(timeout: api.testTimeInSeconds)
    }
}
