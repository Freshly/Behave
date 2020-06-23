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

class MasterViewControllerBDDTests: XCTestCase {
    func testLaunchApp_StartScreen_isMasterViewController() {
        // Test set up
        let expectation = self.expectation(description: "\(#function)")
        let api = Behaviour()

        // Test description
        api.listenFor("master-view") {
            expectation.fulfill()
        }

        // Test running
        api.run { error in
            if let error = error {
                XCTFail(error)
            }
        }
        waitForExpectations(timeout: 10)
    }

//    func testMasterViewController_whenAddNewItemAndTap_thenNavigateToDetailController() {
//        // Test set up
//        let expectation = self.expectation(description: "\(#function)")
//        let api = Behaviour()
//
//        // Test description
//        api.listenFor("master-view") {
//            api.tapRightNavigationItem()
//            api.selectTableRow(identfier: "master-view", indexPath: IndexPath(row: 0, section: 0))
//        }
//
//        api.listenFor("detail-view") {
//            expectation.fulfill()
//        }
//
//        // Test running
//        api.run { error in
//            if let error = error {
//                XCTFail(error)
//            }
//        }
//        waitForExpectations(timeout: 10)
//    }
}
