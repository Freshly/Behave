//
//  Behave+Actions.swift
//  Freshly
//
//  Created by Derek Bronston on 9/27/19.
//  Copyright © 2020 Freshly. All rights reserved.
//
import UIKit

public extension Behaviour {
    func typeIntoTextField(identifier: String, text: String) {
        if let textField = query(identifier: identifier) as? UITextField {
            textField.insertText(text)
        }
    }

    func typeIntoSecureTextField(identifier: String, text: String) {
        if let textField = query(identifier: identifier) as? UITextField {
            textField.insertText(text)
        }
    }

    func tapRightNavigationItem(with object: Any? = nil, with additionalObject: Any? = nil) {
        guard let controller = topMostViewController else { return }
        guard let selector = controller.navigationItem.rightBarButtonItem?.action else { return }

        if let object = object {
            if let additionalObject = additionalObject {
                controller.perform(selector, with: object, with: additionalObject)
            } else {
                controller.perform(selector, with: object)
            }
        } else {
            controller.perform(selector)
        }
    }

    func tapBackButton() {
        topMostViewController?.navigationController?.popViewController(animated: true)
    }

    func tapButton(identifier: String) {
        if let button = query(identifier: identifier) as? UIButton {
            button.sendActions(for: .touchUpInside)
        }
    }

    func selectTabOnTabBar(index: Int) {
        if let tabBar = topMostViewController?.tabBarController {
            tabBar.selectedIndex = index
        }
    }

    func selectTableRow(identfier: String, indexPath: IndexPath) {
        guard let table = query(identifier: identfier) as? UITableView else { return }
        table.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        table.delegate?.tableView?(table, didSelectRowAt: indexPath)
    }
    
    func returnTableCell(identfier: String, indexPath: IndexPath) -> UITableViewCell? {
        guard let table = query(identifier: identfier) as? UITableView else { return nil }
        return table.cellForRow(at: indexPath)
    }

    func scrollTableTo(indexPath: IndexPath, identfier: String) {
        guard let table = query(identifier: identfier) as? UITableView else { return }
        table.scrollToRow(at: indexPath, at: .top, animated: true)
    }

    func selectCollectionItem(identfier: String, indexPath: IndexPath) {
        guard let collection = query(identifier: identfier) as? UICollectionView else { return }
        collection.selectItem(at: indexPath, animated: true, scrollPosition: .bottom)
        collection.delegate?.collectionView?(collection, didDeselectItemAt: indexPath)
    }

    func selectEmebeddedCollectionItem(parentView: UIView, identfier: String, indexPath: IndexPath) {
        guard let collection = findView(view: parentView, identifier: identfier) as? UICollectionView else { return }
        collection.selectItem(at: indexPath, animated: false, scrollPosition: .bottom)
        collection.delegate?.collectionView?(collection, didDeselectItemAt: indexPath)
    }

    func alert() -> Bool {
        guard let alert = topMostViewController as? UIAlertController else { return false }
        alert.dismiss(animated: true)
        return true
    }
}
