//
//  MobileTestPRUITests.swift
//  MobileTestPRUITests
//
//  Created by Derek Bronston on 12/18/18.
//  Copyright © 2018 Freshly. All rights reserved.
//

import XCTest
//import OHHTTPStubs

class MobileTestPRUITests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    //MOB-2161
    func testGivenTheUsersEmailAndPasswordAreEnteredIntoTheLoginFieldsWhenTheUserTapsSubmitAndTheRequestSucceedsThenTheEmailAndPasswordShouldBeClearedFromTheFields(){
        
        let app = XCUIApplication()
        app.launchArguments = ["ui-tests","login-success","{\"success\":true}"]
        app.launch()
        let element = app.otherElements.containing(.navigationBar, identifier:"MobileTestPR.Login").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        
        //ENTER GOOD CREDS
        element.children(matching: .textField).element(boundBy: 0).tap()
        element.children(matching: .textField).element(boundBy: 0).typeText("email@test.com")
        element.children(matching: .textField).element(boundBy: 1).tap()
        element.children(matching: .textField).element(boundBy: 1).typeText("password")
        
        //TAP SUBMIT
        app.buttons["Submit"].tap()
        
        //TAP BACK BUTTON
        app.navigationBars.buttons.element(boundBy: 0).tap()
        
        //TEST
        XCTAssertEqual("", element.children(matching: .textField).element(boundBy: 0).value as! String)
        XCTAssertEqual("", element.children(matching: .textField).element(boundBy: 1).value as! String)
    }
    
    //MOB-2162
    func testGivenTheUsersEmailAndPasswordAreEnteredIntoTheLoginFieldsWhenTheUserTapsSubmitAndTheRequestSucceedsThentheNetworkLoaderShouldBeDismissed(){
        
        let app = XCUIApplication()
        let element = app.otherElements.containing(.navigationBar, identifier:"MobileTestPR.Login").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        element.children(matching: .textField).element(boundBy: 0).tap()
        element.children(matching: .textField).element(boundBy: 0).typeText("email@test.com")
        
        element.children(matching: .textField).element(boundBy: 1).tap()
        element.children(matching: .textField).element(boundBy: 1).typeText("password")
        app.buttons["Submit"].tap()
        
        let item_exists = NSPredicate(format: "exists == false")
        let ac = app.activityIndicators["loader"]
        expectation(for: item_exists , evaluatedWith:ac, handler: nil)
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    //MOB-2163
    func testGivenTheUsersEmailAndPasswordAreEnteredIntoTheLoginFieldsWhenTheUserTapsSubmitAndTheServerSucceedsThenTheUserIsTakenToTheHomeScreen(){
        
        let app = XCUIApplication()
        let element = app.otherElements.containing(.navigationBar, identifier:"MobileTestPR.Login").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        element.children(matching: .textField).element(boundBy: 0).tap()
        element.children(matching: .textField).element(boundBy: 0).typeText("email@test.com")
        
        element.children(matching: .textField).element(boundBy: 1).tap()
        element.children(matching: .textField).element(boundBy: 1).typeText("password")
        app.buttons["Submit"].tap()
        
        let item_exists = NSPredicate(format: "exists == true")
        let ac = app.staticTexts["Home"]
        expectation(for: item_exists , evaluatedWith:ac, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        
    }
    
    
    //MOB-2166
    func testGivenTheUserAttemptsToLoginWithBadCredsWhenCancelButtonOnTheErrorDialogIsPressedThenTheLoaderIsDismissed(){
        
        let app = XCUIApplication()
        let element = app.otherElements.containing(.navigationBar, identifier:"MobileTestPR.Login").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        
        //ENTER BAD CREDS SO THE SPINNER HANGS ON ERROS
        element.children(matching: .textField).element(boundBy: 0).tap()
        element.children(matching: .textField).element(boundBy: 0).typeText("email")
        element.children(matching: .textField).element(boundBy: 1).tap()
        element.children(matching: .textField).element(boundBy: 1).typeText("password")
        
        //TAP SUBMIT
        app.buttons["Submit"].tap()
        
        //CLOSE ERROR DIALOG
        app.buttons["Cancel"].tap()
        
        //TEST
        let item_exists = NSPredicate(format: "exists == false")
        let ac = app.activityIndicators["loader"]
        expectation(for: item_exists , evaluatedWith:ac, handler: nil)
        waitForExpectations(timeout: 2, handler: nil)
        
    }
    
    //MOB-2167
    func testGivenTheUsersEmailAndPasswordAreEnteredIntoTheLoginFieldsWhenTheUserTapsSubmitAndTheRequestFailsThenTheUserIsPresentedWithAnErrorIndicatingAFailure(){
            
            let app = XCUIApplication()
            let element = app.otherElements.containing(.navigationBar, identifier:"MobileTestPR.Login").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
            element.children(matching: .textField).element(boundBy: 0).tap()
            element.children(matching: .textField).element(boundBy: 0).typeText("bad email")
            
            element.children(matching: .textField).element(boundBy: 1).tap()
            element.children(matching: .textField).element(boundBy: 1).typeText("bad password")
            app.buttons["Submit"].tap()
            
            let item_exists = NSPredicate(format: "exists == true")
            let ac = app.alerts["Error"]
            expectation(for: item_exists , evaluatedWith:ac, handler: nil)
            waitForExpectations(timeout: 5, handler: nil)
        
    }
    
    //MOB-2168
    func testGivenTheUsersEmailAndPasswordAreEnteredIntoTheLoginFieldsWhenTheUserTapsSubmitAndTheRequestFailsThenTheEmailAndPasswordShouldBeNotBeCleared(){
        
        let app = XCUIApplication()
        let element = app.otherElements.containing(.navigationBar, identifier:"MobileTestPR.Login").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        
        //ENTER BAD CREDS
        element.children(matching: .textField).element(boundBy: 0).tap()
        element.children(matching: .textField).element(boundBy: 0).typeText("bad email")
        
        element.children(matching: .textField).element(boundBy: 1).tap()
        element.children(matching: .textField).element(boundBy: 1).typeText("bad password")
        
        //PRESS SUBMIT
        app.buttons["Submit"].tap()
        //PRESS CANCEL
        app.buttons["Cancel"].tap()
        
        //TEST
        XCTAssertEqual("bad email", element.children(matching: .textField).element(boundBy: 0).value as! String)
        XCTAssertEqual("bad password", element.children(matching: .textField).element(boundBy: 1).value as! String)
    }
    

    //MOB-2169
    func testGivenTheTheUserHasPreviouslyLoggedInWhenTheUserRelaunchesTheAppThenTheUserShouldAutomaticallyByTakenToTheHomeScreen(){
        
        let app = XCUIApplication()
        let element = app.otherElements.containing(.navigationBar, identifier:"MobileTestPR.Login").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        
        //ENTER GOOD CREDS
        element.children(matching: .textField).element(boundBy: 0).tap()
        element.children(matching: .textField).element(boundBy: 0).typeText("email@test.com")
        element.children(matching: .textField).element(boundBy: 1).tap()
        element.children(matching: .textField).element(boundBy: 1).typeText("password")
        
        //TAP SUBMIT
        app.buttons["Submit"].tap()
        
        //QUIT APP
        XCUIApplication().terminate()
        
        //RELAUNCH
        XCUIApplication().launch()
        XCTAssertEqual("", element.children(matching: .textField).element(boundBy: 0).value as! String)
        XCTAssertEqual("", element.children(matching: .textField).element(boundBy: 1).value as! String)
    }
}
