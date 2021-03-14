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
        cell.textLabel?.text = isEfficent ? "\(efficient())" : "\(inefficient())"
        return cell
    }
    
    // PURELY FOR TESTING
    private func inefficient() -> Double {
        var x: Double = 0.0
        for i in 0...1000000 {
            //print()
            let d = Double(i)
            x = (x * (d)) / 20.0
        }
        
        return x
    }
    
    private func efficient() -> Double {
        return 1.0
    }
    
    private  func add() {
        for i in 0...100 {
            objects.append("\(i)")
        }
    }
}
