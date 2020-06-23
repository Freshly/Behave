//
//  AppDelegate.swift
//  ExampleApp
//
//  Created by Denis Efimov on 6/22/20.
//  Copyright © 2020 Freshly. All rights reserved.
//

import UIKit
import OHHTTPStubs

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let infoArguments = ProcessInfo.processInfo.arguments
        if infoArguments.contains("ui-tests") {
            if infoArguments.contains("login-success") {
                guard let json = ProcessInfo.processInfo.arguments.last else { return true }
                let stubData = json.data(using: String.Encoding.utf8)
                stub(condition: isMethodPOST()) { request -> HTTPStubsResponse in
                    let stubData = json.data(using: String.Encoding.utf8)
                    return HTTPStubsResponse(data:stubData!, statusCode:200, headers:nil)
                }
            }
        }
        
        return true
    }
}

