//
//  ViewControllerOne.swift
//  MobileTestPR
//
//  Created by Derek Bronston on 10/25/19.
//  Copyright © 2019 Freshly. All rights reserved.
//

import UIKit

class ViewControllerOne: UIViewController {

    @IBOutlet weak var testLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let rightButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(rightButtonTap))
        navigationItem.rightBarButtonItem = rightButton
        // Do any additional setup after loading the view.
    }
    
    @IBAction func testButtonTapped(_ sender: Any) {
         testLabel.text = "Test Button Tapped"
    }
    
    @IBAction func navButtonTapped(_ sender: Any) {
       let viewController = storyboard?.instantiateViewController(withIdentifier: "Home")
        navigationController?.pushViewController(viewController!, animated: true)
    }
    
    @objc func rightButtonTap(){
        testLabel.text = "Test Right Button"
    }
}
