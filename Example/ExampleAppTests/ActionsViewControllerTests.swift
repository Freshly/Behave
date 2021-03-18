//
//  ApiViewControllerTests.swift
//  ExampleAppTests
//
//  Created by Derek Bronston on 3/15/21.
//  Copyright © 2021 Freshly. All rights reserved.
//

import XCTest
import Behave
@testable import ExampleApp

class ActionsViewControllerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // Actions
    /**
     typeIntoTextField(identifier: String, text: String)
     */
    func test_typeIntoTextField() {
        let expectations = expectation(description: "done")
        let api = Behaviour()
        navgateToTheApiScreen(api)
        api.listen(for: "actions-view"){
            api.typeIntoTextField(identifier: "text-field", text: "Hello")
            let textField = api.query(identifier: "text-field") as? UITextField
            XCTAssertEqual(textField?.text, "Hello")
            expectations.fulfill()
        }
        api.run(fail: { error in
            XCTFail(error)
        })
        waitForExpectations(timeout: api.testTimeInterval)
    }
    
    /**
     typeIntoSecureTextField(identifier: String, text: String)
     */
    func test_typeIntoSecureTextField() {
        let expectations = expectation(description: "done")
        let api = Behaviour()
        navgateToTheApiScreen(api)
        api.listen(for: "actions-view"){
            api.typeIntoSecureTextField(identifier: "secure-text-field", text: "Hello")
            let textField = api.query(identifier: "secure-text-field") as? UITextField
            XCTAssertEqual(textField?.text, "Hello")
            expectations.fulfill()
        }
        api.run(fail: { error in
            XCTFail(error)
        })
        waitForExpectations(timeout: api.testTimeInterval)
    }
    
    /**
     tapBackButton()
     */
    func test_tapBackButton() {
        let expectations = expectation(description: "done")
        let api = Behaviour()
        navgateToTheApiScreen(api)
        api.listen(for: "actions-view"){
            api.tapBackButton()
        }
        api.listen(for: "list-view") {
            expectations.fulfill()
        }
        api.run(fail: { error in
            XCTFail(error)
        })
        waitForExpectations(timeout: api.testTimeInterval)
    }
    
    /**
     tapButton(identifier: String)
     */
    func test_tapButton() {
        let expectations = expectation(description: "done")
        let api = Behaviour()
        navgateToTheApiScreen(api)
        api.listen(for: "actions-view"){
            api.tapButton(identifier: "button")
            let cell = api.findTable()?.cellForRow(at: IndexPath(row: 0, section: 0))
            XCTAssertEqual(cell?.textLabel?.text, "button action")
            expectations.fulfill()
        }
        api.run(fail: { error in
            XCTFail(error)
        })
        waitForExpectations(timeout: api.testTimeInterval)
    }
    
    /**
     selectTableRow(identfier: String, indexPath: IndexPath)
     */
    func test_selectTableRow() {
        let expectations = expectation(description: "done")
        let api = Behaviour()
        navgateToTheApiScreen(api)
        api.listen(for: "actions-view"){
            api.selectTableRow(identfier: "actions-view", indexPath: IndexPath(row: 0, section: 0))
            let cell = api.findTable()?.cellForRow(at: IndexPath(row: 0, section: 0))
            XCTAssertEqual(cell?.textLabel?.text, "row tapped")
            expectations.fulfill()
        }
        api.run(fail: { error in
            XCTFail(error)
        })
        waitForExpectations(timeout: api.testTimeInterval)

    }
    
    /**
     tapRightNavigationItem(with object: Any? = nil, with additionalObject: Any? = nil)
     */
    func test_tapRightNavigationItem() {
        let expectations = expectation(description: "done")
        let api = Behaviour()
        navgateToTheApiScreen(api)
        api.listen(for: "actions-view"){
            api.tapRightNavigationItem()
        }
        api.waitForAlert {
            expectations.fulfill()
        }
        api.run(fail: { error in
            XCTFail(error)
        })
        waitForExpectations(timeout: api.testTimeInterval)
    }
    
    /**
     scrollTableTo(indexPath: IndexPath, identfier: String)
     */
    func test_scrollTableTo() {
        let expectations = expectation(description: "done")
        let api = Behaviour()
        navgateToTheApiScreen(api)
        api.listen(for: "actions-view"){
            api.selectTableRow(identfier: "actions-view", indexPath: IndexPath(row: 3, section: 0))
            api.scrollTableTo(indexPath: IndexPath(row: 10, section: 0), identfier: "actions-view")
            let cell = api.returnTableCell(identfier: "actions-view", indexPath: IndexPath(row: 10, section: 0))
            XCTAssertNotNil(cell)
            expectations.fulfill()
        }
        api.run(fail: { error in
            XCTFail(error)
        })
        waitForExpectations(timeout: api.testTimeInterval)
    }
    
    /**
     selectTabOnTabBar(index: Int)
     */
    func test_selectTabOnTabBar()  {
        let expectations = expectation(description: "done")
        let api = Behaviour()
        navgateToTheApiScreen(api)
        api.listen(for: "actions-view") {
            api.selectTabOnTabBar(index: 1)
        }
        api.listen(for: "collection-view") {
            expectations.fulfill()
        }
        api.run(fail: { error in
            XCTFail(error)
        })
        waitForExpectations(timeout: api.testTimeInterval)
    }
    
    /**
    selectCollectionItem(identfier: String, indexPath: IndexPath)
    */
   func test_selectCollectionItem() {
        let expectations = expectation(description: "done")
        let api = Behaviour()
        navgateToTheApiScreen(api)
        api.listen(for: "actions-view") {
            api.selectTabOnTabBar(index: 1)
        }
        api.listen(for: "collection-view") {
            api.selectCollectionItem(identfier: "collection-view", indexPath: IndexPath(item: 0, section: 0))
        }
        api.waitForAlert {
            expectations.fulfill()
        }
        api.run(fail: { error in
            XCTFail(error)
        })
        waitForExpectations(timeout: api.testTimeInterval)
   }
    
    private func navgateToTheApiScreen(_ api: Behaviour) {
        api.listen(for: "list-view") {
            api.selectTableRow(identfier: "list-view", indexPath: IndexPath(row: 0, section: 0))
        }
    }
}
