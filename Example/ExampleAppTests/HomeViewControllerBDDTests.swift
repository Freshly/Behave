//
//  ExampleAppTests.swift
//  ExampleAppTests
//
//  Created by Denis Efimov on 6/22/20.
//  Copyright © 2020 Freshly. All rights reserved.
//

import Behave
@testable import ExampleApp
import XCTest

class HomeViewControllerBDDTests: XCTestCase {
    private let homeView = "home-view"
    private let detailView = "detail-view"
    private let addButton = "add-button"
    private let editButton = "edit-button"
    
    func testOnTheHomeViewController_WhenTapRightNavigationButtonItem_ThenAddNewCell() {
        let expectations = expectation(description: "\(#function)")
        let api = Behaviour()
        
        navgateToTheHomeScreen(api)
        
        api.listen(for: homeView) {
            guard let addButton = api.queryBarButtonItem(identifier: self.addButton) else {
                XCTFail("Can't find item")
                expectations.fulfill()
                return
            }
            guard let table = api.query(identifier: self.homeView) as? UITableView else {
                XCTFail("Can't find the table")
                expectations.fulfill()
                return
            }
            api.tapRightNavigationItem(with: addButton)
            XCTAssertNotNil(table.cellForRow(at: IndexPath(row: 0, section: 0)), "Expexted cell is not found")
            expectations.fulfill()
        }

        api.run(fail: { error in
            XCTFail(error)
        })

        waitForExpectations(timeout: api.testTimeInterval)
    }
    
    func testOnTheHomeViewController_WhenCellIsTapped_ThenNavigateToTheDetailScreen() {
        let expectations = expectation(description: "\(#function)")
        let api = Behaviour()
        
        navgateToTheHomeScreen(api)
        
        api.listen(for: homeView) {
            guard let addButton = api.queryBarButtonItem(identifier: self.addButton) else {
                XCTFail("Can't find item")
                expectations.fulfill()
                return
            }
            api.tapRightNavigationItem(with: addButton)
            api.selectTableRow(identfier: self.homeView, indexPath: IndexPath(row: 0, section: 0))
        }

        api.listen(for: detailView) {
            expectations.fulfill()
        }

        api.run(fail: { error in
            XCTFail(error)
        })

        waitForExpectations(timeout: api.testTimeInterval)
    }
    
    func testOnTheHomeViewController_WhenThereIsNoObjects_LeftBarButtonItemIsNotEnabled() {
        let expectations = expectation(description: "\(#function)")
        let api = Behaviour()
        
        navgateToTheHomeScreen(api)
        
        api.listen(for: homeView) {
            guard let editButton = api.queryBarButtonItem(identifier: self.editButton) else {
                XCTFail("Can't find item")
                expectations.fulfill()
                return
            }
            XCTAssertFalse(editButton.isEnabled)
            expectations.fulfill()
        }

        api.run(fail: { error in
            XCTFail(error)
        })

        waitForExpectations(timeout: api.testTimeInterval)
    }
    
    func testOnTheHomeViewController_WhenObjectsAreNotEmpty_LeftBarButtonItemIsEnabled() {
        let expectations = expectation(description: "\(#function)")
        let api = Behaviour()
        
        navgateToTheHomeScreen(api)
        
        api.listen(for: homeView) {
            guard let editButton = api.queryBarButtonItem(identifier: self.editButton) else {
                XCTFail("Can't find item")
                expectations.fulfill()
                return
            }
            guard let addButton = api.queryBarButtonItem(identifier: self.addButton) else {
                XCTFail("Can't find item")
                expectations.fulfill()
                return
            }
            api.tapRightNavigationItem(with: addButton)
            XCTAssertTrue(editButton.isEnabled)
            expectations.fulfill()
        }

        api.run(fail: { error in
            XCTFail(error)
        })

        waitForExpectations(timeout: api.testTimeInterval)
    }
    
    private func navgateToTheHomeScreen(_ api: Behaviour) {
        api.listen(for: "login-view") {
            api.stubNetworkRequest(stub: Stub(httpResponse: 200, jsonReturn: "{\"success\":\"true\"}", urlString: URLS.login.rawValue))
            api.stubNetworkRequest(stub: Stub(httpResponse: 200, jsonReturn: "{\"success\":\"true\"}", urlString: URLS.data.rawValue))
            api.typeIntoTextField(identifier: "email", text: "email")
            api.typeIntoTextField(identifier: "password", text: "password")
            api.tapButton(identifier: "submit")
        }
    }
}
