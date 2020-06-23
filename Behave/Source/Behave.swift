//  Behave.swift
//  Freshly
//
//  Created by Derek Bronston on 9/26/19.
//  Copyright © 2020 Freshly. All rights reserved.

import Foundation
import UIKit

public class Behaviour {
    public var events: [BDEvent]
    public var eventIndex: Int
    public var testTimeInterval: TimeInterval = 10.0

    public init() {
        events = []
        eventIndex = 0
    }

    @discardableResult public func listen(for identifier: String, completion: @escaping () -> Void) -> Self {
        let event = BDEvent(identifier: identifier, complete: completion)
        events.append(event)
        return self
    }

    public func run(success: (() -> Void)? = nil, fail: ((_ error: String) -> Void)? = nil) {
        runTests(success: success, fail: fail)
    }

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
}
