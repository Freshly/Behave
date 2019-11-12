//
//  LoginController.swift
//  MobileTestPR
//
//  Created by Derek Bronston on 12/18/18.
//  Copyright © 2018 Freshly. All rights reserved.
//
import UIKit
import RxSwift
import RxCocoa

class LoginController: UIViewController,ViewControllerProtocol{

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    let viewModel = LoginViewModel()
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindings()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        BehaveV2.sharedInstance.track(eventString: .login)
    }

    private func bindings(){
        binding_error()
        binding_success()
    }
    
    internal func binding_success() {
        viewModel.loginSuccess.subscribe(onNext: {[weak self](_) in
            self?.clearFields()
            self?.loader(show: false)
            self?.navigateToHome()
            #if DEBUG
            Behave.sharedInstance.track(eventString: .loginSuccess)
            #endif
        }).disposed(by: bag)
    }
    
    internal func binding_error() {
        viewModel.error.subscribe(onNext: {[weak self](errorString) in
            self?.loader(show: false)
            self?.displayError(errorMessage: errorString)
        }).disposed(by: bag)
    }
    
    private func navigateToHome(){
        guard let homeViewController = storyboard?.instantiateViewController(withIdentifier: "Home") else { return }
        navigationController?.pushViewController(homeViewController, animated: true)
    }
    
    private func clearFields() {
        emailField.text = ""
        passwordField.text = ""
    }
}
