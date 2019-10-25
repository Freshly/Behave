//
//  HomeViewController.swift
//  MobileTestPR
//
//  Created by Derek Bronston on 10/21/19.
//  Copyright © 2019 Freshly. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    //@IBOutlet weak var tableOne: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
       // tableOne.accessibilityIdentifier = "table-one"
       
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        #if DEBUG
        Behave.sharedInstance.track(eventString: .home)
        #endif
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
