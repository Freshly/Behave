//
//  Behave+Record.swift
//  Behave
//
//  Created by Derek Bronston on 4/21/21.
//

import UIKit

class BehaveRecord {
    var list = [String]()
    static let shared = BehaveRecord()

    private init() {
    }
    
    private static var applicationDocumentsDirectory: String? {
//           let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
//        return paths.first?.appendingFormat("/test.plist")
        let bundlePath = Bundle.main.bundlePath
        return bundlePath.appendingFormat("/test.plist")
    }


    func save() {
        guard let path = BehaveRecord.applicationDocumentsDirectory else { return }
        let array = list as NSArray
        array.write(toFile: path, atomically: true)
    }
    
    func read() -> [NSDictionary]? {
        if let infoPlistPath = BehaveRecord.applicationDocumentsDirectory {
            if FileManager().fileExists(atPath: infoPlistPath) {
                if let arr = NSArray(contentsOfFile: infoPlistPath) {
                
                    return arr as? [NSDictionary]
                 
                }
            }
        }
        return nil
    }
}

extension UITableViewCell {
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch in touches {
            if touch.tapCount > 0 {
                BehaveRecord.shared.list.append(self.accessibilityIdentifier!)
                BehaveRecord.shared.save()
            }
        }
        self.setSelected(true, animated: true)
    }
}

extension UITextField {
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch in touches {
            if touch.tapCount > 0 {
                BehaveRecord.shared.list.append(self.accessibilityIdentifier!)
                BehaveRecord.shared.save()
            }
        }
        self.sendActions(for: .allEvents)
    }
}

extension UIButton {
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch in touches {
            if touch.tapCount > 0 {
                BehaveRecord.shared.list.append(self.accessibilityIdentifier!)
                BehaveRecord.shared.save()
            }
        }
        self.sendActions(for: .allEvents)
    }
}

extension UIView {
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        print(event ?? "")
        print(touches)
    }
}

