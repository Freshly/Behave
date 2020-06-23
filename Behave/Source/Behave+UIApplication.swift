//
//  Behave+UIApplication.swift
//  Freshly
//
//  Created by Derek Bronston on 9/27/19.
//  Copyright © 2020 Freshly. All rights reserved.
//

import UIKit

public extension UIApplication {
    func topMostViewController() -> UIViewController? {
        return keyWindow?.rootViewController?.topMostViewController()
    }
}
