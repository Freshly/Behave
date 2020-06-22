//
//  BDElements.swift
//  BDTestsUnitTests
//
//  Created by Derek Bronston on 8/2/18.
//  Copyright © 2020 Freshly. All rights reserved.
//
import UIKit

public enum BDElementType {
    case button
    case tabbar
    case table
    case collection
    case uiSwitch
    case barButton
}

public struct BDContext {
    public let type: BDElementType
    public let element: Any
}

public struct BDUIElement {
    public let type: BDElementType
    public let element: Any
}

public struct BDTable {
    public let outlet: UITableView
    public let indexPath: IndexPath
    public let select: Bool
}

public struct BDTableV2 {
    public let indexPath: IndexPath
    public let select: Bool
    public let identifier: String?
}

public struct BDCollection {
    public let outlet: UICollectionView
    public let indexPath: IndexPath
    public let select: Bool
}

public struct BDButton {
    public let outlet: UIButton?
    public let identifier: String?
    public let action: UIControl.Event
    public let parent: UIView?
}

public struct BDTabBar {
    public let index: Int
    public let outlet: UITabBarController
}

public struct BDSwitch {
    public let outlet: UISwitch
    public let action: UIControl.Event
}

public struct BDBarButton {
    public let outlet: UIBarButtonItem
}

public struct BDViewDidLoad {}
