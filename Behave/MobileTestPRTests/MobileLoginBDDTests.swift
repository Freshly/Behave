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
import FBSnapshotTestCase

@testable import MobileTestPR

class MobileLoginBDDTests: FBSnapshotTestCase {
    
    override func setUp() {
        Behave.sharedInstance.setUp()
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testTypeIntoTextField() {
        let expectations = expectation(description: "Fullfill")
        let api = BehaveV2()
        api.typeIntoTextField(identifier: "test-textfield", text: "Hello World")
        if let result = api.viewController.query(identifier: "test-textfield") as? UITextField  {
            XCTAssertEqual(result.text, "Hello World")
            expectations.fulfill()
        }
        waitForExpectations(timeout: 3)
    }
    
    func testTapRightNavigationItem() {
        
        let expectations = expectation(description: "Fullfill")
        let api = BehaveV2()
        api.tapRightNavigationItem()
        if let result = api.viewController.query(identifier: "test-label") as? UILabel {
            XCTAssertEqual(result.text, "Test Right Button")
            expectations.fulfill()
        }
        waitForExpectations(timeout: 3)
    }
    
    func testTapButton() {
        let expectations = expectation(description: "Fullfill")
        let api = BehaveV2()
        api.tapButton(identifier: "test-button")
        if let result = api.viewController.query(identifier: "test-label") as? UILabel {
            XCTAssertEqual(result.text, "Test Button Tapped")
            expectations.fulfill()
        }
        waitForExpectations(timeout: 3)
    }
    
//    func testTapBackButton() {
//        
//        let expectations = expectation(description: "Fullfill")
//        let api = BehaveV2()
//        api.tapButton(identifier: "test-nav-button")
//        api.listenFor(event: BDDEvent(event: .home, stub: nil, complete: {
//            api.tapBackButton()
//        }))
//        api.run(finally: { (msg) in
//           // expectations.fulfill()
//        })
//        waitForExpectations(timeout: 20)
//    }
    
    //MOB-2161
    /*func testGivenTheUsersEmailAndPasswordAreEnteredIntoTheLoginFieldsWhenTheUserTapsSubmitAndTheRequestSucceedsThenTheEmailAndPasswordShouldBeClearedFromTheFields(){
        
        let expectations = expectation(description: "Fullfill")
        
        let api = BehaveV2()
        api.stubNetworkRequest(stub: Stub(httpMethod: .post, httpResponse: 200, jsonReturn: "{\"success\":true}"))
        api.typeIntoTextField(identifier: "email", text: "email")
        api.typeIntoTextField(identifier: "password", text: "password")
        api.tapButton(identifier: "submit")
        api.listenFor(event: BDDEvent(event: .loginSuccess, stub: nil, complete: {
            guard let email = api.query(identifier: "email") as? UITextField else { return }
            guard let password = api.query(identifier: "password") as? UITextField else { return }
            XCTAssertEqual(email.text, "")
            XCTAssertEqual(password.text, "")
        }))
        api.run(finally: { (error) in
            if let errorString = error {
                XCTFail(errorString)
            }
            expectations.fulfill()
        })
        
        waitForExpectations(timeout: 3)
    }
    
    //MOB-2163
    func testGivenTheUsersEmailAndPasswordAreEnteredIntoTheLoginFieldsWhenTheUserTapsSubmitAndTheServerSucceedsThenTheUserIsTakenToTheHomeScreen(){

        let expectations = expectation(description: "Fullfill")

        let api = BehaveV2()
        api.stubNetworkRequest(stub: Stub(httpMethod: .post, httpResponse: 200, jsonReturn: "{\"success\":true}"))
        api.typeIntoTextField(identifier: "email", text: "email")
        api.typeIntoTextField(identifier: "password", text: "password")
        api.tapButton(identifier: "submit")
        api.listenFor(event: BDDEvent(event: .home, stub: nil, complete: {
            //self.FBSnapshotVerifyView(api.viewController!.view)
            //self.FBSnapshotVerifyLayer(api.viewController!.view.layer)

        }))
        api.run(finally: { (error) in
            if let errorString = error {
                XCTFail(errorString)
            }
            expectations.fulfill()
        })

        waitForExpectations(timeout: 10)
    }*/
    
}
