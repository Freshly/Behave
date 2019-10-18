//
//  KeychainTests.swift
//  MobileTestPRTests
//
//  Created by Derek Bronston on 10/14/19.
//  Copyright © 2019 Freshly. All rights reserved.
//

import XCTest
import OHHTTPStubs
@testable import MobileTestPR

class KeychainTests: XCTestCase {
    
    let sut = Keychain()
    
    func testSetString() {
        
        // SET UP
        sut.remove(key: "test-key")
        
        // SANITY
        XCTAssertNil(sut.getString(key: "test-key"))
        
        // TEST
        sut.setString(key: "test-key", value: "test-value")
        XCTAssertEqual(sut.getString(key: "test-key"), "test-value")
    }
    
    func testGetString_success() {
        
        // SET UP
        sut.setString(key: "test-key", value: "test-value")
        
        // TEST
        XCTAssertEqual(sut.getString(key: "test-key"), "test-value")
    }
    
    func testGetString_fail() {
        
        // SET UP
        sut.setString(key: "test-key", value: "test-value")
        
        // TEST
        XCTAssertNil(sut.getString(key: "test-key!"))
    }
    
    func testRemove() {
        
        // SET UP
        sut.setString(key: "test-key", value: "test-value")
        
        // SANITY
        XCTAssertNotNil(sut.getString(key: "test-key"), "test-value")
        
        // TEST
        sut.remove(key: "test-key")
        XCTAssertNil(sut.getString(key: "test-key"))
    }
}

