//
//  Behave+ActionsTests.swift
//  MobileTestPRTests
//
//  Created by Derek Bronston on 10/24/19.
//  Copyright © 2019 Freshly. All rights reserved.
//

import XCTest
@testable import MobileTestPR

class Behave_ActionsTests: XCTestCase {
    let sut = BehaveV2()
    var result = false
    
    override func setUp() {
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testTypeIntoTextField() {
        // set up
        let viewController = UIViewController()
        UIApplication.shared.keyWindow?.rootViewController = viewController
        let identifier = "test-text-field"
        let testText = "test-text"
        let textField = UITextField()
        textField.accessibilityIdentifier = identifier
        viewController.view.addSubview(textField)
        
        //TEST
        sut.typeIntoTextField(identifier: identifier, text: testText)
        guard let testTextField = viewController.view.subviews.filter({$0.accessibilityIdentifier == identifier}).first as? UITextField else { XCTFail(); return }
        XCTAssertEqual(testText, testTextField.text)
    }
    
    func testScrollTable() {
        
    }
    
    func testTapRightNavigationItem() {
        
        // SET UP
        let viewController = TestViewController()
        let navController = UINavigationController()
        let rightButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(buttonTap))
        viewController.navigationItem.rightBarButtonItem = rightButton
        navController.viewControllers = [viewController]
        UIApplication.shared.keyWindow?.rootViewController = navController
        
        // SANITY
        XCTAssertFalse(viewController.result)
        
        // TEST
        sut.tapRightNavigationItem()
        XCTAssert(viewController.result)
    }
    
    func testTapBackButton() {
        
        // SET UP
        let viewController1 = UIViewController()
        let viewController2 = TestViewController()
        
        let navController = UINavigationController()
        navController.viewControllers = [viewController1]
        UIApplication.shared.keyWindow?.rootViewController = navController
        navController.pushViewController(viewController2, animated: true)
        
        // SANITY
        XCTAssertFalse(viewController2.result)
        
        // TEST
        sut.tapBackButton()
        XCTAssert(viewController2.result)
    }
    
    func testTapButton() {
    
        // SET UP
        let viewController = UIViewController()
        UIApplication.shared.keyWindow?.rootViewController = viewController
        let identifier = "test-button"
        let button = UIButton()
        button.accessibilityIdentifier = identifier
        button.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
        viewController.view.addSubview(button)
        
        
        // SANITY
        guard let buttonInView = viewController.view.subviews.filter({$0.accessibilityIdentifier == identifier}).first as? UIButton else { XCTFail(); return }
        XCTAssertEqual(buttonInView.state, UIControl.State.normal)
        
        // TEST
        sut.tapButton(identifier: identifier)
        XCTAssert(result)
    }
    
    @objc private func buttonTap() {
       result = true
    }
    
    func testSelectTabOnTabBar() {
        
        // SET UP
        let tabBarController = UITabBarController()
        let viewController1 = UIViewController()
        let viewController2 = UIViewController()
        viewController1.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 0)
        viewController2.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 1)
        tabBarController.viewControllers = [viewController1, viewController2]
        tabBarController.selectedIndex = 0
        UIApplication.shared.keyWindow?.rootViewController = tabBarController
        
        // SANITY
        XCTAssertEqual(tabBarController.selectedIndex, 0)
        
        // TEST
        sut.selectTabOnTabBar(index: 1)
        XCTAssertEqual(tabBarController.selectedIndex, 1)
    }
    
    func testSelectTableRow() {
        
        // SET UP
        let viewController = TestViewController()
        UIApplication.shared.keyWindow?.rootViewController = viewController
        viewController.viewDidLoad()
        
        // SANITY
        XCTAssertEqual(viewController.selectedIndexPathRow, 0)
        XCTAssertEqual(viewController.tableView.numberOfRows(inSection: 0), 10)
        
        // TEST
        let indexPath = IndexPath(row: 2, section: 0)
        sut.selectTableRow(identfier: "test-table", indexPath: indexPath)
        XCTAssertEqual(viewController.selectedIndexPathRow, 2)
    }
    
    func testSelectCollectionItem() {
        
    }
}

class TestViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var result = false
    var tableView: UITableView!
    var selectedIndexPathRow = 0
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = UITableView(frame: view.frame, style: .plain)
        tableView.accessibilityIdentifier = "test-table"
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        result = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    // MARK: User Action
    @objc func buttonTap() {
        result = true
    }
    
    // MARK: Table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell(style: .default, reuseIdentifier: "Cell")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPathRow = indexPath.row
    }
}
