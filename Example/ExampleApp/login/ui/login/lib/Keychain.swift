//
//  Keychain.swift
//  MobileTestPR
//
//  Created by Derek Bronston on 10/14/19.
//  Copyright © 2019 Freshly. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

protocol KeychainProtocol {
    func setString(key: String, value: String)
    func getString(key: String) -> String?
    func remove(key: String)
}

struct Keychain: KeychainProtocol {
    func setString(key: String, value: String) {
        KeychainWrapper.standard.set(value, forKey: key)
    }

    func getString(key: String) -> String? {
        let storedValue = KeychainWrapper.standard.string(forKey: key)
        return storedValue
    }

    func remove(key: String) {
        KeychainWrapper.standard.removeObject(forKey: key)
    }
}
