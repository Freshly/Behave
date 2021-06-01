//
//  AppDelegate.swift
//  ExampleApp
//
//  Created by Denis Efimov on 6/22/20.
//  Copyright © 2020 Freshly. All rights reserved.
//
import OHHTTPStubs
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate{
    var window: UIWindow?

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        #if targetEnvironment(simulator)
        // Disable hardware keyboards.
        let setHardwareLayout = NSSelectorFromString("setHardwareLayout:")
        UITextInputMode.activeInputModes
            // Filter `UIKeyboardInputMode`s.
            .filter({ $0.responds(to: setHardwareLayout) })
            .forEach { $0.perform(setHardwareLayout, with: nil) }
        #endif
       
        let infoArguments = ProcessInfo.processInfo.arguments
        if infoArguments.contains("ui-tests") {
            if infoArguments.contains("login-success") {
                guard let json = ProcessInfo.processInfo.arguments.last else { return true }
                stub(condition: isMethodPOST()) { _ -> HTTPStubsResponse in
                    let stubData = json.data(using: String.Encoding.utf8)
                    return HTTPStubsResponse(data: stubData!, statusCode: 400, headers: nil)
                }
            }
        }
        return true
    }
}

