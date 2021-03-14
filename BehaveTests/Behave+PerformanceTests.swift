//
//  Behave+PerformanceTests.swift
//  BehaveTests
//
//  Created by Derek Bronston on 3/12/21.
//  Copyright © 2021 Freshly. All rights reserved.
//
import XCTest
@testable import Behave


class Behave_PerformanceTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }
    
    func testSetUpPerformanceTest() {
        let sut = Behaviour()
        
        // SET SOME BASE VALUES
        sut.start = 1.0
        sut.end = 1.0
        
        // TEST
        sut.setUpPerformanceTest()
        XCTAssert(sut.start > 1.0)
        XCTAssert(sut.end == 0.0)
    }

    func testMeasurePerformance_false() {
        let sut = Behaviour()
        let passedTest = sut.measurePerformance(frames: 10)
        XCTAssertFalse(passedTest)
    }
    
    func testMeasurePerformance_true() {
        let sut = Behaviour()
        sut.start = NSDate().timeIntervalSince1970 + 1000.0
        let passedTest = sut.measurePerformance(frames: 10)
        XCTAssert(passedTest)
    }
}
