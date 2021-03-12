//
//  HomeViewController.swift
//  ExampleApp
//
//  Created by Denis Efimov on 6/22/20.
//  Copyright © 2020 Freshly. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController {
    var detailViewController: DetailViewController?
    var isEfficent = false
    var objects = [Any]() {
        didSet {
            setupLeftBarButtonItem()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Home"
        view.accessibilityIdentifier = "home-view"

        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.leftBarButtonItem?.accessibilityIdentifier = "edit-button"
        setupLeftBarButtonItem()
        add()

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        addButton.accessibilityIdentifier = "add-button"
        navigationItem.rightBarButtonItem = addButton
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    @objc func insertNewObject(_: Any) {
        isEfficent = true
        objects.insert("Here", at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    func add() {
        for i in 0...100 {
            objects.append("\(i)")
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let story = UIStoryboard(name: "Main", bundle: nil)
        guard let object = objects[indexPath.row] as? NSDate else { return }
        guard let controller = story.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
        
        controller.detailItem = object
        controller.navigationItem.leftItemsSupplementBackButton = true
        detailViewController = controller
        navigationController?.pushViewController(controller, animated: true)
    }

    func setupLeftBarButtonItem() {
        navigationItem.leftBarButtonItem?.isEnabled = objects.count > 0
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

    override func tableView(_: UITableView, canEditRowAt _: IndexPath) -> Bool {
        return true
    }
    
    func inefficient() -> Double {
        var x: Double = 0.0
        for i in 0...1000000 {
            //print()
            let d = Double(i)
            x = (x * (d)) / 20.0
        }
        
        return x
    }
    
    func efficient() -> Double {
        
        return 1.0
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
