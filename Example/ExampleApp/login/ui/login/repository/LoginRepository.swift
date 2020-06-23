//
//  LoginRepository.swift
//  MobileTestPR
//
//  Created by Derek Bronston on 10/9/19.
//  Copyright © 2019 Freshly. All rights reserved.
//

import Foundation

protocol LoginRepositoryProtocol {
    func login(email: String, password: String, complete: @escaping () -> Void, fail: @escaping (_ msg: String) -> Void)
    func savePasswordToKeychain(password: String)
    func saveEmailToKeychain(email: String)
    func retriveUserEmail() -> String?
}

struct LoginRepository: LoginRepositoryProtocol {
    var api: APIProtocol
    var keyChain: KeychainProtocol
    init(api: APIProtocol = API(), keyChain: KeychainProtocol = Keychain()) {
        self.api = api
        self.keyChain = keyChain
    }

    func login(email: String, password: String, complete: @escaping () -> Void, fail: @escaping (_ msg: String) -> Void) {
        api.login(email: email, password: password, success: { () in
            complete()
        }, fail: { msg in
            fail(msg)
        })
    }

    func retriveUserEmail() -> String? {
        return keyChain.getString(key: "email")
    }

    func saveEmailToKeychain(email: String) {
        keyChain.setString(key: "email", value: email)
    }

    func savePasswordToKeychain(password: String) {
        keyChain.setString(key: "password", value: password)
    }
}
