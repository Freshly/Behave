//
//  HomeViewController.swift
//  MobileTestPR
//
//  Created by Derek Bronston on 10/21/19.
//  Copyright © 2019 Freshly. All rights reserved.
//
import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tView: UITableView!
    @IBOutlet weak var resultLabel: UILabel!
    //@IBOutlet weak var tableOne: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tView.accessibilityIdentifier = "test-table"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
        #if DEBUG
        BehaveV2.sharedInstance.track(eventString: .home)
        #endif
    }
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 200
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell.textLabel?.text = "\(indexPath.row)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        resultLabel.text = "\(indexPath.row)"
    }
}
