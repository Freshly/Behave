//  Behave.swift
//  Freshly
//
//  Created by Derek Bronston on 9/26/19.
//  Copyright © 2020 Freshly. All rights reserved.

import Foundation
import UIKit

public class Behaviour {
    /// Waiting time for each event
    public var testTimeInterval: TimeInterval = 20.0
    
    private var events: [BDEvent]
    var requests: [Stub]

    public init() {
        events = []
        requests = []
    }
    // FOR PERFORMANCE
    var start = 0.0
    var end = 0.0

    // MARK: - Methods
    
    /// Adds a new event to the event queue for sequential execution during the test
    /// - Parameters:
    ///   - identifier: An identifier that can be used to access the element
    ///   - completion: A completion block to execute after an element is detected
    /// - Returns: Self instance
    @discardableResult public func listen(for identifier: String, completion: @escaping () -> Void) -> Self {
        let event = BDEvent(identifier: identifier, complete: completion)
        events.append(event)
        return self
    }
    
    /// Starting an event listen queue
    /// - Parameters:
    ///   - success: A completion block to execute after an element is detected
    ///   - fail: A completion block to execute after an element is not detected for expected time
    public func run(success: (() -> Void)? = nil, fail: ((_ error: String) -> Void)? = nil) {
        resetUI()
        runTests(success: success, fail: fail)
    }

    // MARK: - Private methods

    private func runTests(success: (() -> Void)? = nil, fail: ((_ error: String) -> Void)? = nil) {
        if let event = events.first {
            runHelper(event: event, success: success, fail: fail)
        } else {
            success?()
        }
    }

    private func runHelper(event: BDEvent, success: (() -> Void)? = nil, fail: ((_ error: String) -> Void)? = nil) {
        wait(for: event.identifier, complete: { [weak self] in
            event.complete()
            self?.events.removeFirst()
            self?.runTests(success: success, fail: fail)
        }, fail: { error in
            fail?(error)
        })
    }

    private func resetUI() {
        UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: false, completion: {
            if let rootViewController = UIApplication.shared.delegate?.window??.rootViewController {
                if let nav = rootViewController as? UINavigationController {
                    nav.popToRootViewController(animated: false)
                }
            }
        })
        if let rootViewController = UIApplication.shared.delegate?.window??.rootViewController {
            if let nav = rootViewController as? UINavigationController {
                nav.popToRootViewController(animated: false)
            }
            if let tab = rootViewController as? UITabBarController {
                tab.selectedIndex = 0
                if let nav = tab.selectedViewController as? UINavigationController {
                    nav.viewControllers.first?.dismiss(animated: false, completion: {
                        nav.popToRootViewController(animated: false)
                    })
                    nav.popToRootViewController(animated: false)
                }
            }
        }
    }
}
