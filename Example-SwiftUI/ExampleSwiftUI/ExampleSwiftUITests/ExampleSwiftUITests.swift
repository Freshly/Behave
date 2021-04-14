//
//  ExampleSwiftUITests.swift
//  ExampleSwiftUITests
//
//  Created by Derek Bronston on 4/9/21.
//
import SwiftUI
import XCTest
import ViewInspector
@testable import ExampleSwiftUI

extension ExampleSwiftUIApp: CustomReflectable {
    public var customMirror: Mirror {
        return Mirror(reflecting: self)
    }
} // 2.

class ExampleSwiftUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
//        let expectations = expectation(description: "\(#function)")
//        let api = Behave()
//        api.listen(identifier: "hello") {
//            expectations.fulfill()
//        }
//        waitForExpectations(timeout: 5.0)
        
        //Mirror(reflecting:ContentView()).children.forEach { property in
           
           
          
        //let f = FocusedValues()
        
    }
}

class Behave {
    func listen(identifier: String, completion: @escaping () -> Void) {
        let sut = ContentView()
        do {
          _ = try sut.inspect().find(where: { try $0.accessibilityIdentifier() == identifier })
            completion()
        } catch  {
                
        }
    }
}
