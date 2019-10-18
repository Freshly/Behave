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
    
    var sut: LoginController!
    override func setUp() {
        Behave.sharedInstance.setUp()
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    //MOB-2161
    func testGivenTheUsersEmailAndPasswordAreEnteredIntoTheLoginFieldsWhenTheUserTapsSubmitAndTheRequestSucceedsThenTheEmailAndPasswordShouldBeClearedFromTheFields(){
        
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
    /*func testGivenTheUsersEmailAndPasswordAreEnteredIntoTheLoginFieldsWhenTheUserTapsSubmitAndTheServerSucceedsThenTheUserIsTakenToTheHomeScreen(){

        let expectations = expectation(description: "Fullfill")

        let api = BehaveV2()
        api.stubCall(stub: Stub(httpMethod: .post, httpResponse: 200, jsonReturn: "{\"success\":true}"))
        api.typeIntoTextField(identifier: "email", text: "email")
        api.typeIntoTextField(identifier: "password", text: "password")
        api.tapButton(identifier: "submit")
        api.listenFor(event: BDDEvent(event: .loginSuccess, stub: nil, complete: {
            self.FBSnapshotVerifyView(api.viewController!.view)
            self.FBSnapshotVerifyLayer(api.viewController!.view.layer)
            expectations.fulfill()
        }, fail: {(event) in
            XCTFail(event.event.rawValue)
            expectations.fulfill()
        }))
        api.run()

        waitForExpectations(timeout: 10)
    }*/
    
    //MOB-2161 With Snap Shot
    func testGivenTheUsersEmailAndPasswordAreEnteredIntoTheLoginFieldsWhenTheUserTapsSubmitAndTheRequestSucceedsThenTheEmailAndPasswordShouldBeClearedFromTheFields_snap(){
    }
    
    //MOB-2162
    func testGivenTheUsersEmailAndPasswordAreEnteredIntoTheLoginFieldsWhenTheUserTapsSubmitAndTheRequestSucceedsThentheNetworkLoaderShouldBeDismissed(){
    }
    
    
    
    //MOB-2166
    func testGivenTheUserAttemptsToLoginWithBadCredsWhenCancelButtonOnTheErrorDialogIsPressedThenTheLoaderIsDismissed(){
    }
    
    //MOB-2167
    func testGivenTheUsersEmailAndPasswordAreEnteredIntoTheLoginFieldsWhenTheUserTapsSubmitAndTheRequestFailsThenTheUserIsPresentedWithAnErrorIndicatingAFailure(){
    }
    
    //MOB-2168
    func testGivenTheUsersEmailAndPasswordAreEnteredIntoTheLoginFieldsWhenTheUserTapsSubmitAndTheRequestFailsThenTheEmailAndPasswordShouldBeNotBeCleared(){
    }
    
    
    //MOB-2169
    func testGivenTheTheUserHasPreviouslyLoggedInWhenTheUserRelaunchesTheAppThenTheUserShouldAutomaticallyByTakenToTheHomeScreen(){
        
    }
}
