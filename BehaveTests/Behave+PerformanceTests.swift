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
    
    func testMeasurePerformance() {
        let sut = Behaviour()
        
        // SET SOME BASE VALUES
        sut.start = 1.0
        sut.end = 1.0
        sut.passesPerformanceTest = false
        
        // TEST
        sut.measurePerformance()
        XCTAssert(sut.start == 0.0)
        XCTAssert(sut.end == 0.0)
        XCTAssert(sut.passesPerformanceTest)
    }
    
    func testCalculatePerformance_true() {
        let sut = Behaviour()
        
        // SET SOME BASE VALUES
        sut.start = 0.0167
        sut.end = 0.0334
        sut.passesPerformanceTest = true
        
        sut.calculatePerformance()
        XCTAssert(sut.passesPerformanceTest)
    }
    
    func testCalculatePerformance_false() {
        let sut = Behaviour()
        
        // SET SOME BASE VALUES
        sut.start = 0.0167
        sut.end = 0.0444
        sut.passesPerformanceTest = true
        
        sut.calculatePerformance()
        XCTAssertFalse(sut.passesPerformanceTest)
    }
}
