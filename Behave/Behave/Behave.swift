//  Behave.swift
//  Freshly
//
//  Created by Derek Bronston on 9/26/19.
//  Copyright © 2020 Freshly. All rights reserved.

import Foundation
import UIKit

class Behave {
    var events = [BDEvent]()
    var eventIndex = 0
    var viewController: UIViewController!
    var finalCall: (String?) -> Void = { _ in }

    @discardableResult func listenFor(_ identifier: String, completion: @escaping () -> Void) -> Self {
        let event = BDEvent(identifier: identifier, complete: completion)
        events.append(event)
        return self
    }

    func run(finally: @escaping (_ errorString: String?) -> Void) {
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
