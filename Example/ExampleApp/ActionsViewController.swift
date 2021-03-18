//
//  HomeViewController.swift
//  ExampleApp
//
//  Created by Denis Efimov on 6/22/20.
//  Copyright © 2020 Freshly. All rights reserved.
//

import UIKit

class ActionsViewController: UITableViewController {
    var list = ["TextField",
                "SecureTextField",
                "Button",
                "Scroll Table",
                ""]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rightButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(tapRightButton))
        rightButton.accessibilityIdentifier = "right-nav-button"
        navigationItem.rightBarButtonItem = rightButton
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.accessibilityIdentifier = "actions-view"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @objc func tapRightButton() {
        displayError(errorMessage: "Alert")
    }

    // MARK: - Table View
    override func numberOfSections(in _: UITableView) -> Int {
        return 1
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            tableView.cellForRow(at: indexPath)?.textLabel?.text = "row tapped"
            break
        case 3:
            addToTable()
            break
        default:
            break
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        switch list[indexPath.row] {
        case "TextField":
            cell.contentView.addSubview(returnTextField(view: cell.contentView))
            break;
        case "SecureTextField":
            cell.contentView.addSubview(returnSecureTextField(view: cell.contentView))
            break;
        case "Button":
            cell.contentView.addSubview(returnButton(view: cell.contentView))
            break;
        default:
            cell.textLabel?.text = "row \(indexPath.row)"
            break;
        }
        
        return cell
    }

    override func tableView(_: UITableView, canEditRowAt _: IndexPath) -> Bool {
        return true
    }
    
    private func returnTextField(view: UIView) -> UITextField {
        let textField = UITextField()
        textField.frame = CGRect(x: 0.0, y: 0.0, width: view.frame.size.width, height: view.frame.size.height)
        textField.accessibilityIdentifier = "text-field"
        return textField
    }
    
    private func returnSecureTextField(view: UIView) -> UITextField {
        let textField = UITextField()
        textField.isSecureTextEntry = true
        textField.frame = CGRect(x: 0.0, y: 0.0, width: view.frame.size.width, height: view.frame.size.height)
        textField.accessibilityIdentifier = "secure-text-field"
        return textField
    }
    
    private func returnButton(view: UIView) -> UIButton{
        let button = UIButton()
        button.isEnabled = true
        button.frame = CGRect(x: 0.0, y: 0.0, width: view.frame.size.width, height: view.frame.size.height)
        button.accessibilityIdentifier = "button"
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }
    
    @objc private func buttonAction() {
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))
        cell?.textLabel?.text = "button action"
    }
    
    private func addToTable() {
        for number in 0...50 {
            list.append("test: \(number)")
        }
        tableView.reloadData()
    }
}

