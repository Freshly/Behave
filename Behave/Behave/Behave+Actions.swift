//
//  Behave+Actions.swift
//  Freshly
//
//  Created by Derek Bronston on 9/27/19.
//  Copyright © 2019 Derek Bronston. All rights reserved.
//

import UIKit


extension BehaveV2 {
    
    func typeIntoTextField(identifier:String, text: String) {
        if let textField = query(identifier: identifier) as? UITextField {
            textField.text = text
        }
    }
    
//    func scrollTable() {
//
//    }
//
    func tapRightNavigationItem() {
        if let SEL = UIApplication.shared.topMostViewController()?.navigationItem.rightBarButtonItem?.action  {
            UIApplication.shared.topMostViewController()?.perform(SEL)
        }
    }
    
    func tapBackButton() {
        if let SEL = UIApplication.shared.topMostViewController()?.navigationItem.backBarButtonItem?.action  {
            UIApplication.shared.topMostViewController()?.perform(SEL)
        }
    }
    
    func tapButton(identifier:String) {
        if let button = query(identifier: identifier) as? UIButton {
            button.sendActions(for: .touchUpInside)
        }
    }
    
    func selectTabOnTabBar(index:Int) {
        if let tabBar = UIApplication.shared.topMostViewController()?.tabBarController {
            tabBar.selectedIndex = index
        }
    }
    
//    func selectTableRow(indexPath:IndexPath) {
//        guard let table = findTable() else { return }
//        DispatchQueue.main.async {
//            table.selectRow(at: indexPath, animated: false, scrollPosition: .none)
//            table.delegate?.tableView!(table, didSelectRowAt:indexPath)
//        }
//    }
//
//    func selectCollectionItem(indexPath:IndexPath) {
//        guard let collection = findCollection() else { return }
//        DispatchQueue.main.async {
//            collection.selectItem(at: indexPath, animated: false, scrollPosition: .top)
//            collection.delegate?.collectionView?(collection, didDeselectItemAt: indexPath)
//        }
//    }
    
    func selectTableRow(identfier:String, indexPath:IndexPath) {
        guard let table = query(identifier: identfier) as? UITableView else { return }
        table.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        table.delegate?.tableView!(table, didSelectRowAt:indexPath)
    }
}
