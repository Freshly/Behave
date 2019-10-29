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

class BehaveActionsTests: FBSnapshotTestCase {
    
    override func setUp() {
        Behave.sharedInstance.setUp()
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    private func tearDownUI() {
        let api = BehaveV2()
        api.scrollTableTo(indexPath: IndexPath(row: 0, section: 0), identfier: "test-table")
        api.tapBackButton()
        api.selectTabOnTabBar(index: 0)
    }
    
    func testTypeIntoTextField() {
        let expectations = expectation(description: "Fullfill")
        let api = BehaveV2()
        api.typeIntoTextField(identifier: "test-textfield", text: "Hello World")
        if let result = api.viewController.query(identifier: "test-textfield") as? UITextField  {
            XCTAssertEqual(result.text, "Hello World")
            tearDownUI()
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
            tearDownUI()
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
            tearDownUI()
            expectations.fulfill()
        }
        waitForExpectations(timeout: 3)
    }
    
    func testTapBackButton() {

        let expectations = expectation(description: "Fullfill")
        let api = BehaveV2()
        api.tapButton(identifier: "test-nav-button")
        api.listenFor(event: BDDEvent(event: .home, stub: nil, complete: {
            api.tapBackButton()
        }))
        api.listenFor(event: BDDEvent(event: .login, stub: nil, complete: {
            guard let _ = api.viewController.query(identifier: "test-button") as? UIButton else {
                XCTFail()
                return
            }
        }))
        api.run(finally: { (error) in
            if let errorString = error {
                XCTFail(errorString)
            }
            self.tearDownUI()
            expectations.fulfill()
        })
        waitForExpectations(timeout: 20)
    }
    
    func testSelectTabOnTabBar() {
        let expectations = expectation(description: "Fullfill")
        let api = BehaveV2()
        api.selectTabOnTabBar(index: 1)
        api.listenFor(event: BDDEvent(event: .login, stub: nil, complete: {
            guard let _ = api.query(identifier: "submit-button") else { XCTFail(); return }
        }))
        api.run(finally: {(msg) in
            if let errorString = msg {
                XCTFail(errorString)
            }
            self.tearDownUI()
            expectations.fulfill()
        })
        waitForExpectations(timeout: 3)
    }
    
    func testSelectTableRow() {
        
        let expectations = expectation(description: "Fullfill")
        let api = BehaveV2()
        api.tapButton(identifier: "test-nav-button")
        api.listenFor(event: BDDEvent(event: .home, stub: nil, complete: {
            api.selectTableRow(identfier: "test-table", indexPath: IndexPath(row: 1, section: 0))
            guard let label = api.query(identifier: "results-label") as? UILabel else {
                XCTFail(); return
            }
            XCTAssertEqual(label.text, "1")
        }))
        api.run(finally: {(msg) in
            if let errorString = msg {
                XCTFail(errorString)
            }
            self.tearDownUI()
            expectations.fulfill()
        })
        waitForExpectations(timeout: 3)
    }
    
    func testScrollToTableRow() {
        
        let expectations = expectation(description: "Fullfill")
        let api = BehaveV2()
        api.tapButton(identifier: "test-nav-button")
        api.listenFor(event: BDDEvent(event: .home, stub: nil, complete: {
            api.scrollTableTo(indexPath: IndexPath(row: 100, section: 0), identfier: "test-table")
            api.selectTableRow(identfier:  "test-table", indexPath: IndexPath(row: 100, section: 0))
            guard let label = api.query(identifier: "results-label") as? UILabel else {
                XCTFail(); return
            }
            XCTAssertEqual(label.text, "100")
        }))
        api.run(finally: {(msg) in
            if let errorString = msg {
                XCTFail(errorString)
            }
            self.tearDownUI()
            expectations.fulfill()
        })
        waitForExpectations(timeout: 3)
    }
    
    func testCollection() {
        let expectations = expectation(description: "Fullfill")
        let api = BehaveV2()
        api.tapButton(identifier: "test-nav-collection-button")
        api.listenFor(event: BDDEvent(event: .collection, stub: nil, complete: {
            api.selectCollectionItem(identfier: "collection", indexPath: IndexPath(item: 10, section: 0))
        }))
        api.listenFor(event: BDDEvent(event: .login, stub: nil, complete: {
            guard let _ = api.viewController.query(identifier: "test-button") as? UIButton else {
                XCTFail()
                return
            }
        }))
        api.run(finally: {(msg) in
            if let errorString = msg {
                XCTFail(errorString)
            }
            self.tearDownUI()
            expectations.fulfill()
        })
        waitForExpectations(timeout: 3)
    }
    
    func testAlert() {
        let expectations = expectation(description: "Fullfill")
        let api = BehaveV2()
        api.tapButton(identifier: "test-show-alert-button")
        api.listenFor(event: BDDEvent(event: .actionSheet, stub: nil, complete: {
            XCTAssert(api.alert())
        }))
        api.run(finally: {(msg) in
            if let errorString = msg {
                XCTFail(errorString)
            }
            self.tearDownUI()
            expectations.fulfill()
        })
        waitForExpectations(timeout: 3)
    }
}
