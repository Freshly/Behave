//
//  LoginRepositoryTests.swift
//  MobileTestPRTests
//
//  Created by Derek Bronston on 10/14/19.
//  Copyright © 2019 Freshly. All rights reserved.
//

import XCTest

@testable import MobileTestPR

class LoginRepositoryTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLogin_success() {
        // TODO
    }
    
    func testLogin_fail() {
        // TODO
    }
    
    func testRetriveUserEmail_string(){
        
        // SET UP
        let mockKeyChain = MockKeyChain()
        mockKeyChain.success = true
        let sut = LoginRepository(keyChain: mockKeyChain)
        
        // TEST
        XCTAssertEqual(sut.retriveUserEmail(), "value")
    }
    
    func testRetriveUserEmail_nil(){
        // SET UP
        let mockKeyChain = MockKeyChain()
        mockKeyChain.success = false
        let sut = LoginRepository(keyChain: mockKeyChain)
        
        // TEST
        XCTAssertNil(sut.retriveUserEmail())
    }
}

class MockKeyChain: KeychainProtocol {
    
    var success = false
    func setString(key: String, value: String) {
        // TODO
    }
    
    func getString(key: String) -> String? {
        return success == true ? "value" : nil
    }
    
    func remove(key: String) {
        // TODO
    }
    
    
}
