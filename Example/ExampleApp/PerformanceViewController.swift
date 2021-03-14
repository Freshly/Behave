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
        cell.textLabel?.text = isEfficent ? "\(efficient(row: indexPath.row))" : "\(inefficient(row: indexPath.row))"
        return cell
    }
    
    // PURELY FOR TESTING
    private func inefficient(row: Int) -> String {
        var x: Double = 0.0
        for i in 0...1000000 {
            //print()
            let d = Double(i)
            x = (x * (d)) / 20.0
        }
        return "Row: \(row)"
    }
    
    private func efficient(row: Int) -> String {
        return "Row: \(row)"
    }
    
    private  func add() {
        for i in 0...100 {
            objects.append("\(i)")
        }
    }
}
