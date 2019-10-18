//
//  BehaveEvent+Extension.swift
//  Freshly
//
//  Created by Derek Bronston on 9/27/19.
//  Copyright © 2019 Derek Bronston. All rights reserved.
//

import Foundation

// THIS FILE WILL LIVE OUTSIDE THE POD, IT IS CLIENT SPECIFIC
extension BehaveEvent {
    static let upcoming = BehaveEvent("upcoming")
    static let login = BehaveEvent("login")
    static let loginSuccess = BehaveEvent("loginSuccess")
    static let account = BehaveEvent("account")
    static let manageSubscription = BehaveEvent("manage-subscription")
    static let weeklyDefaultPlan = BehaveEvent("weekly-default-plan")
    static let planSelected = BehaveEvent("plan-selected")
    static let actionSheet = BehaveEvent("action-sheet")
}
