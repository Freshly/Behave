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
    public var finalCall: (String?) -> Void
    public var testTimeInSeconds = 10.0
    
    public init() {
        events = []
        eventIndex = 0
        finalCall = { _ in }
    }

    @discardableResult public func listenFor(_ identifier: String, completion: @escaping () -> Void) -> Self {
        let event = BDEvent(identifier: identifier, complete: completion)
        events.append(event)
        return self
    }

    public func run(finally: @escaping (_ errorString: String?) -> Void) {
        finalCall = finally
        runTests()
    }

    private func runTests() {
        if let event = events.first {
            runHelper(event: event)
        } else {
            _ = finalCall(nil)
        }
    }

    private func runHelper(event: BDEvent) {
        waitFor(identifier: event.identifier, complete: {
            event.complete()
            self.events.removeFirst()
            self.runTests()
        }, fail: { msg in
            self.finalCall(msg)
        })
    }
}
