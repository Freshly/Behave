//
//  HomeViewController.swift
//  ExampleApp
//
//  Created by Denis Efimov on 6/22/20.
//  Copyright © 2020 Freshly. All rights reserved.
//

import UIKit

class PerformanceViewController: UITableViewController {
    var isEfficent = true
    var objects = [""]

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Performance"
        view.accessibilityIdentifier = "performance-view"
        add()
        let efficiencyButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(updateEfficency(_:)))
        efficiencyButton.accessibilityIdentifier = "efficiency-button"
        navigationItem.rightBarButtonItem = efficiencyButton
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    @objc func updateEfficency(_: Any) {
        isEfficent = false
        tableView.reloadData()
    }
    
    // MARK: - Table View
    override func numberOfSections(in _: UITableView) -> Int {
        return 1
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return objects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if isEfficent {
            cell.textLabel?.text = "\(efficient(row: indexPath.row))"
        } else {
            cell.textLabel?.text = "\(efficient(row: indexPath.row))"
            
            for _ in 0...100 {
                let sview2 = UIView(frame: CGRect(x: 10000.0, y: 10000.0, width: 10000.0, height: 10000.0))
                cell.contentView.addSubview(sview2)
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let sview = UIView(frame: CGRect(x: 10000.0, y: 10000.0, width: 10000.0, height: 10000.0))
        sview.accessibilityIdentifier = "row-\(indexPath.row)"
        view.addSubview(sview)
    }
    
    // PURELY FOR TESTING
    private func efficient(row: Int) -> String {
        return "Row: \(row)"
    }
    
    private  func add() {
        for i in 0...100 {
            objects.append("\(i)")
        }
    }
}
