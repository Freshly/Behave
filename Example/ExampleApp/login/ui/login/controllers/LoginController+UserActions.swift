//
//  LoginController+UserActions.swift
//  MobileTestPR
//
//  Created by Derek Bronston on 12/18/18.
//  Copyright © 2018 Freshly. All rights reserved.
//
import UIKit
extension LoginController {
    @IBAction func login() {
        loader(show: true)
        _ = viewModel.login(email: emailField.text!, password: passwordField.text!)
    }
}
