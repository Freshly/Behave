//
//  LoginViewModel.swift
//  MobileTestPR
//
//  Created by Derek Bronston on 12/18/18.
//  Copyright © 2018 Freshly. All rights reserved.
//
import Foundation
import RxCocoa
import RxSwift

struct LoginViewModel {
    // UI
    let emailFieldLabel = "Email"
    let passwordFieldLabel = "Password"
    let submitButtonLabel = "Submit"

    // OUTPUTS
    let error = PublishRelay<String>()
    let loginSuccess = PublishRelay<Bool>()
    var repo: LoginRepositoryProtocol

    init(repo: LoginRepositoryProtocol = LoginRepository()) {
        self.repo = repo
    }

    // MARK: METHODS

    func login(email: String, password: String) {
        
        repo.login(email: email, password: password, complete: {
            self.repo.data(complete: {
                self.processloginSucceess()
            }, fail: { msg in
                self.displayError(errorString: msg)
            })
        }, fail: { msg in
            self.displayError(errorString: msg)
        })
    }

    func processloginSucceess() {
        loginSuccess.accept(true)
    }

    func displayError(errorString: String) {
        error.accept(errorString)
    }

    func isUserLoggedIn() -> Bool {
        guard let _ = repo.retriveUserEmail() else { return false }
        return true
    }
}
