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
    
    func tapRightNavigationItem() {
        if let SEL = UIApplication.shared.topMostViewController()?.navigationItem.rightBarButtonItem?.action  {
            UIApplication.shared.topMostViewController()?.perform(SEL)
        }
    }
    
    func tapBackButton() {
        UIApplication.shared.topMostViewController()?.navigationController?.popViewController(animated: true)
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
    
    func selectTableRow(identfier:String, indexPath:IndexPath) {
        guard let table = query(identifier: identfier) as? UITableView else { return }
        table.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        table.delegate?.tableView!(table, didSelectRowAt:indexPath)
    }
    
    func scrollTableTo(indexPath: IndexPath, identfier:String) {
        guard let table = query(identifier: identfier) as? UITableView else { return }
        table.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
    func selectCollectionItem(identfier:String, indexPath:IndexPath) {
        guard let collection = query(identifier: identfier) as? UICollectionView else { return }
        collection.selectItem(at: indexPath, animated: true, scrollPosition: .bottom)
        collection.delegate?.collectionView?(collection, didDeselectItemAt: indexPath)
    }
    
    func alert() -> Bool {
        guard let alert =  UIApplication.shared.topMostViewController() as? UIAlertController else { return false }
        alert.dismiss(animated: true, completion: {})
        return true
    }
}
