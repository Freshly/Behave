//
//  BehaveRecorder.swift
//  ExampleApp
//
//  Created by Derek Bronston on 4/22/21.
//  Copyright © 2021 Freshly. All rights reserved.
//
import UIKit

class BehaveRecorder {
    
    static let shared = BehaveRecorder()
    var event: String?
    var list = [[String: Any]]()
    
    func findIdentifier(touch: UITouch, view: UIView) -> String? {
        
        if let id = view.accessibilityIdentifier  {
            return id
        }
        return nil
    }
    
    func findParentIdentifier(view: UIView) -> String? {
        if let parent = view.superview?.accessibilityIdentifier {
            return parent
        }
        return nil
    }
    
    func recordAction(view: UIView) {
        guard let viewType = BehaveRecorder.shared.returnViewType(view: view) else { return }
    
        switch viewType {
        case "table-view-cell":
            BehaveRecorder.shared.prepareTableViewAction(view: view)
        case "collection-view-cell":
            BehaveRecorder.shared.prepareCollectionViewAction(view: view)
        case "text-field":
            BehaveRecorder.shared.prepareTextFieldAction(view: view)
        case "button":
            BehaveRecorder.shared.prepareButtonAction(view: view)
        default:
            return
        }
    }
    
    func returnViewType(view: UIView) -> String? {
        if view is UITableViewCell {
            return "table-view-cell"
        }
        if view is UICollectionViewCell {
            return "collection-view-cell"
        }
        if view is UITextField {
            return "text-field"
        }
        if view is UIButton {
            return "button"
        }
        return nil
    }
    
    func prepareTextFieldAction(view: UIView) {
        
    }
    
    func prepareButtonAction(view: UIView) {
        
        guard let identifier = view.accessibilityIdentifier else { return }
       
        let action = [
            "identifier": identifier,
            "action": "button-tap",
            "customData": ""
            
        ] as [String : Any]
        BehaveRecorder.shared.list.append(action)
        print(BehaveRecorder.shared.list)
    }
    
    func prepareTableViewAction(view: UIView) {
        guard let parent = view.superview?.accessibilityIdentifier else {
            return
        }
        
        guard let customDataRaw = view.accessibilityIdentifier else { return }
        let splitData = customDataRaw.components(separatedBy: "|") as Array<String> 
        guard let row = Int(splitData.first ?? "") else {
            return
        }
        guard let section = Int(splitData.last ?? "") else {
            return
        }
        
        let action = [
            "identifier": parent,
            "action": "select-table-row",
            "customData": [
                "row": row,
                "section": section
            ]
        ] as [String : Any]
        BehaveRecorder.shared.list.append(action)
        print(BehaveRecorder.shared.list)
    }
    
    func prepareCollectionViewAction(view: UIView) {
        guard let parent = view.superview?.accessibilityIdentifier else {
            return
        }
        
        guard let customDataRaw = view.accessibilityIdentifier else { return }
        let splitData = customDataRaw.components(separatedBy: "|") as Array<String>
        guard let row = Int(splitData.first ?? "") else {
            return
        }
        guard let section = Int(splitData.last ?? "") else {
            return
        }
        
        let action = [
            "identifier": parent,
            "action": "select-collection-item",
            "customData": [
                "row": row,
                "section": section
            ]
        ] as [String : Any]
        BehaveRecorder.shared.list.append(action)
        print(BehaveRecorder.shared.list)
    }
}

//extension UIViewController: TouchCaptureGesture {}
extension UITableViewCell {
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        print(touches)
        for touch in touches {
            if touch.tapCount > 0 {
                //BehaveRecord.shared.list.append(self.accessibilityIdentifier!)
                //BehaveRecord.shared.save()
            }
        }
        super.touchesBegan(touches, with: event)
    }
}

extension UICollectionViewCell {
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        print(touches)
        for touch in touches {
            if touch.tapCount > 0 {
                //BehaveRecord.shared.list.append(self.accessibilityIdentifier!)
                //BehaveRecord.shared.save()
            }
        }
        super.touchesBegan(touches, with: event)
    }
}
//
extension UITextField {
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        print(touches)
        //BehaveRecorder.shared.recordAction(view: self)
        //self.sendActions(for: .allEvents)
        super.touchesBegan(touches, with: event)
    }
    
}

extension UIInputView {
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        print(touches)
        //BehaveRecorder.shared.recordAction(view: self)
        //self.sendActions(for: .allEvents)
        super.touchesBegan(touches, with: event)
    }
}

extension UIButton {
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        //print(touches)
        BehaveRecorder.shared.recordAction(view: self)
        super.touchesBegan(touches, with: event)
    }
}

extension UITabBar {
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        print(touches)
        BehaveRecorder.shared.recordAction(view: self)
        super.touchesBegan(touches, with: event)
    }
}

extension UIView {
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        BehaveRecorder.shared.recordAction(view: self)
        super.touchesBegan(touches, with: event)
    }
}
