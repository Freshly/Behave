//  BehaveV2.swift
//  Freshly
//
//  Created by Derek Bronston on 9/26/19.
//  Copyright © 2019 Derek Bronston. All rights reserved.

import Foundation
import UIKit
import RxSwift
import RxCocoa
import OHHTTPStubs

struct BDDError {
    let event: BDDEvent
}

class BehaveV2 {
    
    var event = PublishRelay<String>()
    var identifier:String?
    
    var stubs = [Stub]()
    let bag = DisposeBag()
    var worker: DispatchWorkItem?
    var events = [BDDEvent]()
    
    var viewController: UIViewController!
    var eventIndex = 0
    var testPassed = false
    var finalCall: (String?) -> Void = { _ in  }
    static let sharedInstance = BehaveV2()
    
    init() {
        if let controller = UIApplication.shared.topMostViewController() {
            self.viewController = controller
        }
    }
    
    @discardableResult func add(event: BDDEvent) -> Self {
        events.append(event)
        return self
    }
    
    @discardableResult func listenFor(event: BDDEvent) -> Self {
        events.append(event)
        return self
    }
    
    func run(finally:@escaping (_ errorString: String?) -> Void) {
        finalCall = finally
        self.testPassed = false
        runTests()
    }
    
    private func runTests(){
        if let event = events.first {
            self.testPassed = false
            runHelper(event: event)
        } else {
            _ = finalCall(nil)
        }
    }
    
    private func runHelper(event: BDDEvent){
    
            let eventString = BehaveV2.sharedInstance.setEvent(eventString: event.event)
            if let stub = event.stub {
                self.stubNetworkRequest(stub: stub)
            }
            BehaveV2.sharedInstance.event.subscribe(onNext: {(str) in
                if self.events.count < 1 { return }
                if str == eventString {
                    if let controller = UIApplication.shared.topMostViewController() {
                        self.viewController = controller
                    }
                    self.testPassed = true
                    event.complete()
                    self.events.removeFirst()
                    self.runTests()
                }
            }).disposed(by: self.bag )
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { timer in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                if !self.testPassed {
                    _ = self.finalCall(event.event.rawValue)
                    self.events.removeFirst()
                }
            }
        }
    }
}

