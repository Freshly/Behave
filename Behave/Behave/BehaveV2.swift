//
//  BehaveV2.swift
//  Freshly
//
//  Created by Derek Bronston on 9/26/19.
//  Copyright © 2019 Derek Bronston. All rights reserved.
//
import Foundation
import UIKit
import RxSwift
import RxCocoa
import OHHTTPStubs

struct BDDError {
    let event: BDDEvent
}

class BehaveV2 {
    
    var stubs = [Stub]()
    let bag = DisposeBag()
    var worker: DispatchWorkItem?
    var events = [BDDEvent]()
    
    var viewController: UIViewController!
    var eventIndex = 0
    var testPassed = false
    var finalCall: (String?) -> Void = { _ in  }
    
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
    
            let eventString = Behave.sharedInstance.setEvent(eventString: event.event)
            if let stub = event.stub {
                self.stubNetworkRequest(stub: stub)
            }
            Behave.sharedInstance.event.subscribe(onNext: {(str) in
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
    
    @discardableResult func run(eventString: String ,complete: ()->Void) -> BehaveV2 {
        return self
    }
    
    func findTable()-> UITableView? {
        
        guard let view = UIApplication.shared.topMostViewController()?.view else { return nil }
        if view is UITableView {
            return view as? UITableView
        }
        for subview in view.subviews {
            if subview is UITableView {
                return subview as? UITableView
            }
        }
        return nil
    }
    
    func findCollection()-> UICollectionView? {
        
        guard let view = UIApplication.shared.topMostViewController()?.view else { return nil }
        if view is UICollectionView {
            return view as? UICollectionView
        }
        for subview in view.subviews {
            if subview is UICollectionView {
                return subview as? UICollectionView
            }
        }
        return nil
    }
    
    func findButton(identifier:String)-> UIButton? {
        
        if let button = query(identifier: identifier) as? UIButton {
            return button
        }
        
        if let button =  UIApplication.shared.topMostViewController()?.navigationItem.titleView?.subviews.filter({$0.accessibilityIdentifier == identifier}).first as? UIButton {
            return button
        }
        
        if let button = UIApplication.shared.topMostViewController()?.view.subviews.filter({$0.accessibilityIdentifier == identifier}).first as? UIButton {
            return button
        }
        
        if let table = UIApplication.shared.topMostViewController()?.view.subviews.filter({$0 is UITableView}).first as? UITableView  {
            let rows = table.numberOfRows(inSection: 0)
            for i in 0...rows {
                if let cell = table.cellForRow(at: IndexPath(row: i, section: 0)) {
                    if let button = cell.contentView.subviews.filter({$0.accessibilityIdentifier == identifier}).first as? UIButton {
                        return button
                    }
                }
            }
        }
        return nil
    }
    
    func tabBarWithOutlet(tbar:BDTabBar) -> Bool {
        tbar.outlet.selectedIndex = tbar.index
        return true
    }
    
    func query(identifier:String) -> UIView? {
        let windows = UIApplication.shared.windows
        for window in windows {
            let subviews = window.subviews
            for subview in subviews {
                if let view = findView(view: subview, identifier: identifier){
                    return view
                }
            }
        }
        return nil
    }
    
    func findView(view:UIView,identifier:String) -> UIView? {
        for subview in view.subviews {
            if subview.accessibilityIdentifier == identifier {
                return subview
            } else {
                if let view = childView(view: subview,identifier:identifier){
                    return view
                }
            }
        }
        return nil
    }
    
    private func childView(view:UIView,identifier:String) -> UIView? {
        for subview in view.subviews {
            if subview.accessibilityIdentifier == identifier {
                return subview
            } else {
                if let view = childView(view: subview,identifier:identifier){
                    return view
                }
            }
        }
        return nil
    }
    
    func waitFor(identifier: String,parent:UIView,complete:@escaping () -> Void){
        
        var runCount = 0
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            
            if  (self.viewController.findView(view: parent, identifier: identifier) != nil){
                complete()
                timer.invalidate()
            }
            runCount += 1
            if runCount == 10 {
                timer.invalidate()
            }
        }
    }
}


