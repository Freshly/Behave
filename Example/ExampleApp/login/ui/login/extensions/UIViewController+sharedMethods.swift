//
//  UIViewController+sharedMethods.swift
//  MobileTestPR
//
//  Created by Derek Bronston on 12/18/18.
//  Copyright © 2018 Freshly. All rights reserved.
//

import UIKit

extension UIViewController {
    func loader(show: Bool) {
        if !show {
            guard let spinner = view.subviews.filter({ $0.tag == Tags.loadingTag.rawValue }).first else { return }
            spinner.isHidden = true
            return
        }

        if let spinner = view.subviews.filter({ $0.tag == Tags.loadingTag.rawValue }).first {
            spinner.isHidden = false
            return
        }

        let loadingView = UIView()
        loadingView.frame = view.bounds
        loadingView.tag = Tags.loadingTag.rawValue
        loadingView.backgroundColor = UIColor.clear

        let bg = UIView()
        bg.frame = view.bounds
        bg.backgroundColor = UIColor.black
        bg.alpha = 0.6
        loadingView.addSubview(bg)

        let frame = CGRect(x: (view.frame.width - 20) / 2,
                           y: (view.frame.height - (20 + 10)) / 2,
                           width: 20.0,
                           height: 20.0)
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.accessibilityIdentifier = "loader"
        activityIndicator.frame = frame
        activityIndicator.style = .white
        activityIndicator.startAnimating()

        loadingView.addSubview(activityIndicator)
        view.addSubview(loadingView)
    }

    func displayError(errorMessage: String) {
        let alertController = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            self.loader(show: false)
        })
        action.accessibilityIdentifier = "cancel"
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
}
