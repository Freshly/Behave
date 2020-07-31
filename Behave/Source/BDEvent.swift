//
//  BDEvent.swift
//  Behave
//
//  Created by Denis Efimov on 6/22/20.
//  Copyright © 2020 Freshly. All rights reserved.
//
import Foundation

public struct BDEvent {
    public let identifier: String
    public let complete: () -> Void
}
