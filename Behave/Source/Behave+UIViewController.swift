//
//  Behave+UIViewController.swift
//  Freshly
//
//  Created by Derek Bronston on 9/27/19.
//  Copyright © 2020 Freshly. All rights reserved.
//

import UIKit

public extension UIViewController {
    func topMostViewController() -> UIViewController {
        if let presented = presentedViewController {
            return presented.topMostViewController()
        }

        if let navigation = self as? UINavigationController {
            return navigation.visibleViewController?.topMostViewController() ?? navigation
        }

        if let tab = self as? UITabBarController {
            return tab.selectedViewController?.topMostViewController() ?? tab
        }
        return self
    }
}

extension Behaviour {
    var topMostViewController: UIViewController? {
        return UIApplication.shared.topMostViewController()
    }
}
