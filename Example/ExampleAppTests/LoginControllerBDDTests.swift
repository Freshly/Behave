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
import UIKit

@testable import ExampleApp

class MockRepo: LoginRepositoryProtocol {
    func login(email: String, password: String, complete: @escaping () -> Void, fail: @escaping (String) -> Void) {
        complete()
    }
    
    func savePasswordToKeychain(password: String) {
        
    }
    
    func saveEmailToKeychain(email: String) {
      
    }
    
    func retriveUserEmail() -> String? {
        return ""
    }
    
    
}

class LoginControllerBDDTests: XCTestCase {
    func testGivenTheUsersEmailAndPasswordAreEnteredIntoTheLoginFieldsWhenTheUserTapsSubmitAndTheRequestSucceedsThenDisplayHome() {
        let expectations = expectation(description: "\(#function)")
        let api = Behaviour()
        api.listen(for: "login-view") {
            if let controller = UIApplication.shared.topMostViewController() as? LoginController {
                controller.viewModel = LoginViewModel(repo: MockRepo())
                controller.binding_success()
                
                //controller.viewModel =
                //api.stubNetworkRequest(stub: Stub(httpMethod: HTTPMethods.post, httpResponse: 200, jsonReturn: "{\"success\":\"true\"}"))
                api.typeIntoTextField(identifier: "email", text: "email")
                api.typeIntoTextField(identifier: "password", text: "password")
                api.tapButton(identifier: "submit")
            }
        }
        api.listen(for: "home-view") {
            expectations.fulfill()
        }
        api.run { error in
            if let errorString = error {
                XCTFail(errorString)
                expectations.fulfill()
            }
        }
        waitForExpectations(timeout: api.testTimeInSeconds)
    }
}
