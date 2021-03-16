//
//  HomeViewController.swift
//  ExampleApp
//
//  Created by Denis Efimov on 6/22/20.
//  Copyright © 2020 Freshly. All rights reserved.
//

import UIKit

class ExampleListViewController: UITableViewController {
    var list = ["Actions", "Performance", "Networking", "Behave vs. XCTest UI"]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.accessibilityIdentifier = "list-view"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let story = UIStoryboard(name: "Main", bundle: nil)
        switch indexPath.row {
        case 0:
            guard let controller = story.instantiateViewController(withIdentifier: "Actions") as? ActionsViewController else { return }
            navigationController?.pushViewController(controller, animated: true)
            break
        case 1:
            guard let controller = story.instantiateViewController(withIdentifier: "Performance") as? PerformanceViewController else { return }
            navigationController?.pushViewController(controller, animated: true)
            break
        case 2:
            guard let controller = story.instantiateViewController(withIdentifier: "Home") as? HomeViewController else { return }
            navigationController?.pushViewController(controller, animated: true)
            break
        case 3:
            guard let controller = story.instantiateViewController(withIdentifier: "Login") as? LoginController else { return }
            navigationController?.pushViewController(controller, animated: true)
            break
        default:
            break
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK: - Table View

    override func numberOfSections(in _: UITableView) -> Int {
        return 1
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return list.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let object = list[indexPath.row]
        cell.textLabel?.text = object
        return cell
    }

    override func tableView(_: UITableView, canEditRowAt _: IndexPath) -> Bool {
        return true
    }
}

