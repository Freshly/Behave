//
//  LoginViewModelTests.swift
//  MobileTestPRTests
//
//  Created by Derek Bronston on 12/18/18.
//  Copyright © 2018 Freshly. All rights reserved.
//
import XCTest
import RxSwift
import RxCocoa

@testable import MobileTestPR

class LoginViewModelTests: XCTestCase {
    
    let bag = DisposeBag()
    
    override func setUp() {
    }

    override func tearDown() {
    }
    
    func testClearCoverage() {}

    //MARK: UI
    func testEmailFieldLabel(){
        let mockRepo = MockLoginRepo()
        let sut = LoginViewModel(repo: mockRepo)
        XCTAssertEqual(sut.emailFieldLabel, "Email")
    }
    
    func testPasswordFieldLabel(){
        let mockRepo = MockLoginRepo()
        let sut = LoginViewModel(repo: mockRepo)
        XCTAssertEqual(sut.passwordFieldLabel, "Password")
    }
    
    func testSubmitButtonLabel(){
        let mockRepo = MockLoginRepo()
        let sut = LoginViewModel(repo: mockRepo)
        XCTAssertEqual(sut.emailFieldLabel, "Email")
    }
    
    //MARK: Methods
    
    // THIS IS AN EXAMPLE OF A GOOD TEST
    func testLogin_success_loginSuccessTrue(){
        
        // SET UP
        let validationExpectation = self.expectation(description: "Fullfilled")
        let mockRepo = MockLoginRepo()
        mockRepo.sucess = true 
        let sut = LoginViewModel(repo: mockRepo)
        
        // TEST
        sut.loginSuccess.subscribe(onNext: {(success) in
           XCTAssert(success)
           validationExpectation.fulfill()
        }).disposed(by: bag)

        sut.login(email: "email", password: "pass")
        
        self.waitForExpectations(timeout: 3){ error in }
    }
    
    // THIS IS AN EXAMPLE OF A FALSE POSITIVE
    func testLogin_exampleOfAFalsePositive_success(){
        
        // SET UP
        let mockRepo = MockLoginRepo()
        mockRepo.sucess = false
        let sut = LoginViewModel(repo: mockRepo)
        
        // TEST
        sut.loginSuccess.subscribe(onNext: {(success) in
            XCTAssert(success)
        }).disposed(by: bag)
        
        sut.login(email: "email", password: "pass")
    }
    

    func testLogin_badCredsEntered_fail(){
        // SET UP
        let validationExpectation = self.expectation(description: "Fullfilled")
        let mockRepo = MockLoginRepo()
        mockRepo.sucess = false
        let sut = LoginViewModel(repo: mockRepo)
        
        // TEST
        sut.error.subscribe(onNext: {(msg) in
            XCTAssertEqual(msg, "error")
            validationExpectation.fulfill()
        }).disposed(by: bag)
        
        sut.login(email: "email", password: "pass")
        
        self.waitForExpectations(timeout: 3){ error in }
    }
    
    func testProcessLoginSuccess_true(){
        
        let mockRepo = MockLoginRepo()
        let sut = LoginViewModel(repo: mockRepo)
        let validationExpectation = self.expectation(description: "Fullfilled")
        sut.loginSuccess.subscribe(onNext: {(sucess) in
            validationExpectation.fulfill()
            XCTAssert(sucess)
        }).disposed(by: bag)
        
        // TEST
        sut.processloginSucceess()
        self.waitForExpectations(timeout: 3){ error in }
    }
    
    func testDisplayError_errorString(){
        
        // SET UP
        let mockRepo = MockLoginRepo()
        let sut = LoginViewModel(repo: mockRepo)
        let validationExpectation = self.expectation(description: "Fullfilled")
        sut.error.subscribe(onNext: {(msg) in
            validationExpectation.fulfill()
            XCTAssertEqual(msg, "error")
        }).disposed(by: bag)
        
        // TEST
        sut.displayError(errorString: "error")
        self.waitForExpectations(timeout: 3){ error in }
    }
    
    func testIsUserLoggedIn_success() {
        
        // SET UP
        let mockRepo = MockLoginRepo()
        mockRepo.sucess = true
        let sut = LoginViewModel(repo: mockRepo)
        
        // TEST
        XCTAssert(sut.isUserLoggedIn())
    }
    
    func testIsUserLoggedIn_fail() {
        
        // SET UP
        let mockRepo = MockLoginRepo()
        mockRepo.sucess = false
        let sut = LoginViewModel(repo: mockRepo)
        
        // TEST
        XCTAssertFalse(sut.isUserLoggedIn())
    }
}

class MockLoginRepo: LoginRepositoryProtocol {
    
    var sucess = false
    func login(email: String, password: String, complete: @escaping () -> Void, fail: @escaping (String) -> Void) {
        
        if sucess {
            complete()
        } else {
            fail("error")
        }
    }
    
    func retriveUserEmail() -> String? {
        if sucess {
            return "email"
        } else {
            return nil
        }
    }
    
    func savePasswordToKeychain(password: String) {
        // TODO
    }
    
    func saveEmailToKeychain(email: String) {
        // TODO
    }
    
}
