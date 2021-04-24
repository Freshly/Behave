//  Behave.swift
//  Freshly
//
//  Created by Derek Bronston on 9/26/19.
//  Copyright © 2020 Freshly. All rights reserved.

import Foundation
import UIKit

public class Behaviour {
    /// Waiting time for each event
    public var testTimeInterval: TimeInterval = 10.0
    public var swiftui = false
    private var events: [BDEvent]
    private var storedEvents: [Array<NSDictionary>]
    private var eventFailures: [String]
    var requests: [Stub]

    public init() {
        events = []
        requests = []
        storedEvents = []
        eventFailures = []
    }
    // FOR PERFORMANCE
    var frameStart = 0.0
    var frameEnd = 0.0
    public var passesPerformanceTest = false
    
    // FOR AUTO PLAY
    public var autoPlay = false
    //public var testFile = ""

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
    
    
    //private func createActions() -> [[String: String]]
    
    /// Starting an event listen queue
    /// - Parameters:
    ///   - success: A completion block to execute after an element is detected
    ///   - fail: A completion block to execute after an element is not detected for expected time
    public func run(success: (() -> Void)? = nil, fail: ((_ error: String) -> Void)? = nil) {
        //resetUI()
        if !swiftui {
            runTests(success: success, fail: fail)
        } else {
            runSwiftUITests(success: success, fail: fail)
        }
    }
    
    // MARK: Automated Tests
    
    private func readEvents() {
        if storedEvents.count > 0 {
            return
        }
        if let testEvents = BehaveRecord.shared.read(){
            storedEvents = testEvents as! [Array<NSDictionary>]
        }
    }
    
    private func addEvents() {
        if let testEvents = storedEvents.first  {
            for testEvent in testEvents {
                var eventIdentifier = ""
                if let event = testEvent["identifier"] as? String {
                    eventIdentifier = event
                }
                if let actions = testEvent["action"] as? String {
                    if let customData = testEvent["customData"] as? NSDictionary {
                    addEvent(for: eventIdentifier, action: actions,customData: customData,completion: {})
                    }
                } else {
                    addEvent(for: eventIdentifier,completion: {})
                }
            }
        }
        
    }
    
    private func addEvent(for identifier: String, action: String? = nil, customData: NSDictionary? = nil ,completion: @escaping () -> Void) {
        let event = BDEvent(identifier: identifier, complete: completion, action: action, customData: customData)
        events.append(event)
    }
    
    private func completeStoredTest()  {
        if storedEvents.count > 0 {
            storedEvents.removeFirst()
        }
    }
    
    public func play(complete: (([String]) -> Void)? = nil) {
        autoPlay = true
        readEvents()
        addEvents()
        playAutomatedTests(complete: complete)
    }
    
    private func playAutomatedTests(complete: (([String]) -> Void)? = nil) {
        
        guard let event = events.first else {
            complete?(eventFailures)
            return
        }
        
        if event.action == "stub-network-request" {
            runActions(complete: {
                self.events.removeFirst()
                playAutomatedTests(complete: complete)
            })
        } else {
            wait(for: event.identifier, complete: {[weak self] in
                self?.runActions(complete: {
                    self?.events.removeFirst()
                    self?.playAutomatedTests(complete: complete)
                })
            }, fail: { [weak self] error in
                self?.eventFailures.append(error)
                self?.events.removeFirst()
                self?.playAutomatedTests(complete: complete)
            })
        }
    }
    
    private func runActions(complete: (() -> Void)) {
        if let action = self.events.first {
            runAction(for: action.identifier, action: action)
            complete()
        }
    }
    
    private func runAction(for identifier: String, action: BDEvent ){
        if let actionType = action.action {
            switch actionType {
            case "select-table-row":
                guard let customData = action.customData else { return }
                guard let row = customData["row"] as? Int else { return }
                guard let section = customData["section"] as? Int else { return }
                selectTableRow(identfier: identifier, indexPath: IndexPath(row: row as Int, section: section))
            break
            case "type-into-textfield":
                guard let customData = action.customData else { return }
                guard let text = customData["text"] as? String else { return }
                typeIntoTextField(identifier: identifier, text: text)
            break
            case "type-into-secure-textfield":
                guard let customData = action.customData  else { return }
                guard let text = customData["text"] as? String else { return }
                typeIntoSecureTextField(identifier: identifier, text: text)
            break
            case "tap-button":
                tapButton(identifier: identifier)
            break
            case "stub-network-request":
                guard let customData = action.customData  else { return }
                guard let url = customData["url"] as? String else { return }
                guard let json = customData["json"] as? String else { return }
                guard let httpResponse = customData["response"] as? Int else { return }
                stubNetworkRequest(stub: Stub(httpResponse: Int32(httpResponse), jsonReturn: json, urlString: url))
            break
            case "wait-for-alert":
                waitForAlert {
                    
                }
            break
            default:
                return
            }
        }
    }

    // MARK: - Private methods
    
    private func runSwiftUITests(success: (() -> Void)? = nil, fail: ((_ error: String) -> Void)? = nil) {
        
    }

    private func runTests(success: (() -> Void)? = nil, fail: ((_ error: String) -> Void)? = nil) {
        if let event = events.first {
            runHelper(event: event, success: success, fail: fail)
        } else {
            success?()
        }
    }

    private func runHelper(event: BDEvent, success: (() -> Void)? = nil, fail: ((_ error: String) -> Void)? = nil) {
        print(event)
        if event.identifier == "alert" {
            waitForAlert { [weak self] in
                if !self!.autoPlay {
                    self?.events.removeFirst()
                    self?.runTests(success: success, fail: fail)
                } else {
//                    self?.runActions(complete: {
//                        self?.events.removeFirst()
//                        self?.runTests(success: success, fail: fail)
//                    })
                }
            }
        } else if event.identifier == "stub-network-request"{
            runAction(for: event.identifier, action: event)
            self.events.removeFirst()
            self.runTests(success: success, fail: fail)
        } else {
            wait(for: event.identifier, complete: { [weak self] in
                event.complete()
                if !self!.autoPlay {
                    self?.events.removeFirst()
                    self?.runTests(success: success, fail: fail)
                } else {
                    self?.runActions(complete: {
                        self?.events.removeFirst()
                        self?.runTests(success: success, fail: fail)
                    })
                }
            }, fail: { [weak self] error in
                self?.eventFailures.append(error)
                fail?(error)
            })
        }
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
