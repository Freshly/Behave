//
//  BDElements.swift
//  BDTestsUnitTests
//
//  Created by Derek Bronston on 8/2/18.
//  Copyright © 2018 Derek Bronston. All rights reserved.
//
import UIKit

enum  BDElementType {
    
    case button
    case tabbar
    case table
    case collection
    case uiSwitch
    case barButton
}

struct BDContext {
    let type:BDElementType
    let element:Any
}

struct BDUIElement{
    let type:BDElementType
    let element:Any
}

struct BDTable {
    let outlet:UITableView
    let indexPath:IndexPath
    let select:Bool
}

struct BDTableV2 {
    let indexPath:IndexPath
    let select:Bool
    let identifier:String?
}

struct BDCollection {
    let outlet:UICollectionView
    let indexPath:IndexPath
    let select:Bool
}

struct BDButton {
    let outlet:UIButton?
    let identifier:String?
    let action:UIControl.Event
    let parent:UIView?
}

struct BDTabBar {
    let index:Int
    let outlet:UITabBarController
}

struct BDSwitch{
    let outlet:UISwitch
    let action:UIControl.Event
}

struct BDBarButton{
    let outlet:UIBarButtonItem
}

struct BDViewDidLoad {
    
}
