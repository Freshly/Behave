//
//  BDTestsBDD.swift
//  BDTestsUnitTests
//
//  Created by Derek Bronston on 7/31/18.
//  Copyright © 2018 Derek Bronston. All rights reserved.
//
import UIKit
import RxSwift
import RxCocoa

class Behave {
    var eventPub = PublishSubject<String>()
    var event:Observable<String>!
    var logoutPub = PublishSubject<String>()
    var logout:Observable<String>!
    var identifier:String?
    
    init() {
        setUp()
    }

    func setUp() {
        self.event = eventPub.asObserver()
                            .observeOn(MainScheduler.instance)
        _ = eventPub.observeOn(MainScheduler.instance)
        
        self.logout = logoutPub
        _ = logoutPub.observeOn(MainScheduler.instance)

    }
    
    func send(identity:String){
        
        guard let testIdentifier = identifier else { return }
        identifier = nil
        
        eventPub.on(.next(testIdentifier + identity))
    }
}

extension UIViewController {
    
    func givenTheUser(doesThis:String,withThis:BDUIElement,weExpect:String, afterAnUpdateToThisContext:BDContext?, letsVerify: @escaping() -> Void, orDoSomethingElse:@escaping() -> Void) -> Bool{
        
        switch withThis.type {
        case .button:
            if let context = afterAnUpdateToThisContext {
                waitForContext(context: context, triggered: {
                    letsVerify()
                    orDoSomethingElse()
                })
               return button(uiElement: withThis.element)
            } else {
                let executed = button(uiElement: withThis.element)
                if executed {
                    letsVerify()
                    orDoSomethingElse()
                    return true
                }
            }
            return false
            
        case .table:
            if let context = afterAnUpdateToThisContext {
                waitForContext(context: context, triggered: {
                    letsVerify()
                    orDoSomethingElse()
                })
                return table(uiElement: withThis.element)
            } else {
                let executed = table(uiElement: withThis.element)
                if executed{
                    letsVerify()
                    orDoSomethingElse()
                    return true
                }
            }
            return false
            
        case .tabbar:
            let executed = tabBar(uiElement: withThis.element)
            if executed{
                letsVerify()
                orDoSomethingElse()
                return true
            }
            return false
            
        case .collection:
            let executed = collection(uiElement: withThis.element)
            if executed{
                letsVerify()
                orDoSomethingElse()
                return true
            }
            return false
            
        case .uiSwitch:
            let executed = uiswitch(uiElement: withThis.element)
            if executed{
                letsVerify()
                orDoSomethingElse()
                return true
            }
            return false
            
        case .barButton:
            let executed = barButton(uiElement: withThis.element)
            if executed{
                letsVerify()
                orDoSomethingElse()
                return true
            }
            return false
        }
    }
    
    func waitForContext(context:BDContext,triggered:@escaping () -> Void){
        if context.type == .table {
            guard let tbl = context.element as? BDTable else { return  }
            if #available(iOS 11.0, *) {
                tbl.outlet.performBatchUpdates({
                }, completion: {(complete) in
                    triggered()
                })
            } else {
                
            }
        }
        
        if context.type == .collection {
            guard let col = context.element as? BDCollection else { return  }
            col.outlet.performBatchUpdates({
            }, completion: {(complete) in
                triggered()
            })
        }
    }
    
    //MARK: UI ELEMENTS
    func tabBar(uiElement:Any) -> Bool {
        guard let tb = uiElement as? BDTabBar else { return false }
        return tabBarWithOutlet(tbar:tb)
        
    }
    
    func table(uiElement:Any) -> Bool {
        guard let tbl = uiElement as? BDTable else { return false }
        return tableWithOutlet(table: tbl)
    }
    
    func collection(uiElement:Any) -> Bool {
        guard let cltion = uiElement as? BDCollection else { return false }
        return collectionWithOutlet(collection: cltion)
    }
    
    func button(uiElement:Any) -> Bool {
        guard let theButton = uiElement as? BDButton else { return false }
        if let _ = theButton.outlet {
            return buttonWithOutlet(button:theButton)
        } else if let _ = theButton.identifier {
            return buttonWithIdentifier(button: theButton)
        }
        return false
    }
    
    func button(behaviour:String,uiElement:Any) -> Bool {
        guard let theButton = uiElement as? BDButton else { return false }
        if let _ = theButton.outlet {
            return buttonWithOutlet(button:theButton)
        } else if let _ = theButton.identifier {
            return buttonWithIdentifier(button: theButton)
        }
        return false
    }
    
    func freshlyActionSheetButton(behaviour:String,identifier:String){
        guard let table = query(identifier: "action-sheet-table") as? UITableView else {  return }
        
        let rows = table.numberOfRows(inSection: 0)
        for i in 0...rows {
            guard let cell = table.cellForRow(at: IndexPath(row: i, section: 0)) else { return }
            let btn = BDButton(outlet: nil, identifier:identifier.lowercased(), action: .touchUpInside, parent: cell.contentView)
            if button(uiElement: btn) {
                UIApplication.shared.windows[0].makeKey()
                return
            }
        }
        
    }
    
    func collection(behaviour:String,uiElement:Any){
        guard let collection = uiElement as? BDCollection else { return }
        _ = collectionWithOutlet(collection: collection)
    }
    
    func uiswitch(uiElement:Any) -> Bool {
        guard let uiSwitch = uiElement as? BDSwitch else { return false }
        uiSwitch.outlet.sendActions(for: uiSwitch.action)
        return true
    }
    
    func barButton(uiElement:Any) -> Bool {
        guard let bButton = uiElement as? BDBarButton else { return false }
        UIApplication.shared.sendAction(bButton.outlet.action!, to: nil, from: nil, for: nil)
        return true
    }
    
    //MARK: HANDLE UI ELEMENTS
    private func tabBarWithOutlet(tbar:BDTabBar) -> Bool {
        tbar.outlet.selectedIndex = tbar.index
        return true
    }
    
    private func tableWithOutlet(table:BDTable) -> Bool{
        if table.select {
            DispatchQueue.main.async {
                table.outlet.selectRow(at: table.indexPath, animated: false, scrollPosition: .none)
                table.outlet.delegate?.tableView!(table.outlet, didSelectRowAt: table.indexPath)
                
            }
            return true
        }
        return false
    }
    
    private func collectionWithOutlet(collection:BDCollection) -> Bool{
        if collection.select {
            collection.outlet.selectItem(at: collection.indexPath, animated: true, scrollPosition: .centeredHorizontally)
            collection.outlet.delegate?.collectionView!(collection.outlet, didDeselectItemAt: collection.indexPath)
            return true
        }
        return false
    }
    
    //PRESS THE BUTTON ASSOCIATED WITH THE OUTLET
    private func buttonWithOutlet(button:BDButton) -> Bool {
        guard let outlet = button.outlet else { return false }
        outlet.sendActions(for: button.action)
        return true
    }
    
    //FIND THE BUTTON BASED ON THE IDENTIFIER. RECURSIVELY SEARCH ITS PARENT VIEW
    private func buttonWithIdentifier(button:BDButton) -> Bool{
        if let identifier = button.identifier {
            guard let parent = button.parent else { return false }
            if let returnedButton = findView(view: parent, identifier: identifier) as? UIButton {
                returnedButton.sendActions(for: button.action)
                return true
            }
        }
        return false
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
}
