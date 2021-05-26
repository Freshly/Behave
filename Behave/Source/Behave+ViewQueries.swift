//
//  Behave+ViewQueries.swift
//  MobileTestPR
//
//  Created by Derek Bronston on 11/12/19.
//  Copyright © 2019 Freshly. All rights reserved.
//

import UIKit

public extension Behaviour {
    var timerInterval: TimeInterval { return 0.1 }
    var attemptsMaximumNumber: Int { return 100 }
    
    func findTable() -> UITableView? {
        guard let view = topMostViewController?.view else { return nil }
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

    func findCollection() -> UICollectionView? {
        guard let view = topMostViewController?.view else { return nil }
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

    func findButton(identifier: String) -> UIButton? {
        if let button = query(identifier: identifier) as? UIButton {
            return button
        }

        if let button = topMostViewController?.navigationItem.titleView?.subviews.filter({ $0.accessibilityIdentifier == identifier }).first as? UIButton {
            return button
        }

        if let button = topMostViewController?.view.subviews.filter({ $0.accessibilityIdentifier == identifier }).first as? UIButton {
            return button
        }

        if let table = topMostViewController?.view.subviews.filter({ $0 is UITableView }).first as? UITableView {
            let rows = table.numberOfRows(inSection: 0)
            for i in 0 ... rows {
                if let cell = table.cellForRow(at: IndexPath(row: i, section: 0)) {
                    if let button = cell.contentView.subviews.filter({ $0.accessibilityIdentifier == identifier }).first as? UIButton {
                        return button
                    }
                }
            }
        }
        return nil
    }

    func tabBarWithOutlet(tbar: BDTabBar) -> Bool {
        tbar.outlet.selectedIndex = tbar.index
        return true
    }

    func queryBarButtonItem(identifier: String) -> UIBarButtonItem? {
        if let rightBarButton = topMostViewController?.navigationItem.rightBarButtonItem {
            if rightBarButton.accessibilityIdentifier == identifier {
                return rightBarButton
            }
        }
        if let leftBarButton = topMostViewController?.navigationItem.leftBarButtonItem {
            if leftBarButton.accessibilityIdentifier == identifier {
                return leftBarButton
            }
        }
        return nil
    }

    func query(identifier: String) -> UIView? {
        let windows = UIApplication.shared.windows
        for window in windows {
            let subviews = window.subviews
            for subview in subviews {
                if let view = findView(view: subview, identifier: identifier) {
                    return view
                }
            }
        }
        return nil
    }

    func findView(view: UIView, identifier: String) -> UIView? {
        for subview in view.subviews {
            if subview.accessibilityIdentifier == identifier {
                return subview
            } else {
                if let view = childView(view: subview, identifier: identifier) {
                    return view
                }
            }
        }
        return nil
    }

    private func childView(view: UIView, identifier: String) -> UIView? {
        for subview in view.subviews {
            if subview.accessibilityIdentifier == identifier {
                return subview
            } else {
                if let view = childView(view: subview, identifier: identifier) {
                    return view
                }
            }
        }
        return nil
    }

    func waitForAlert(complete: @escaping () -> Void) {
        var runCount: Int = 0
        Timer.scheduledTimer(withTimeInterval: timerInterval, repeats: true) { [weak self] timer in
            guard let self = self else {
                timer.invalidate()
                return
            }
            if let _ = self.topMostViewController as? UIAlertController {
                complete()
                timer.invalidate()
                return
            }
            
            runCount += 1
            if runCount == self.attemptsMaximumNumber {
                timer.invalidate()
            }
        }
    }
    
    func wait(for identifier: String, parent: UIView, complete: @escaping () -> Void) {
        var runCount: Int = 0
        Timer.scheduledTimer(withTimeInterval: timerInterval, repeats: true) { [weak self] timer in
            guard let self = self else {
                timer.invalidate()
                return
            }

            if self.findView(view: parent, identifier: identifier) != nil {
                complete()
                timer.invalidate()
            }
            runCount += 1
            if runCount == self.attemptsMaximumNumber {
                timer.invalidate()
            }
        }
    }

    func wait(for identifier: String, complete: @escaping () -> Void, fail: @escaping (_ errorString: String) -> Void) {
        var runCount = 0
        Timer.scheduledTimer(withTimeInterval: timerInterval, repeats: true) { [weak self] timer in
            guard let self = self else {
                timer.invalidate()
                return
            }
            guard let viewController = self.topMostViewController else { fail(identifier)
                timer.invalidate()
                return
            }
            if let parent = viewController.view {
                if parent.accessibilityIdentifier == identifier || self.findView(view: parent, identifier: identifier) != nil {
                    complete()
                    timer.invalidate()
                    return
                }
            }
            runCount += 1
            if runCount == self.attemptsMaximumNumber {
                timer.invalidate()
                fail(identifier)
            }
        }
    }
    
    func wait(for cell: IndexPath, parent: UITableView, complete: @escaping (UITableViewCell?) -> Void) {
        var runCount: Int = 0
        while runCount < self.attemptsMaximumNumber {
            if let tableCell = parent.cellForRow(at: cell) {
                runCount = self.attemptsMaximumNumber
                complete(tableCell)
            }
        }
    }
}
