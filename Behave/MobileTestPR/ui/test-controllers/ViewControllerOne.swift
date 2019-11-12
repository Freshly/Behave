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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        #if DEBUG
        BehaveV2.sharedInstance.track(eventString: .login)
        #endif
    }
    
    @IBAction func testButtonTapped(_ sender: Any) {
         testLabel.text = "Test Button Tapped"
    }
    
    @IBAction func navButtonTapped(_ sender: Any) {
       let viewController = storyboard?.instantiateViewController(withIdentifier: "Home")
        navigationController?.pushViewController(viewController!, animated: true)
    }
    @IBAction func navToCollection(_ sender: Any) {
        let viewController = storyboard?.instantiateViewController(withIdentifier: "CollectionView")
        navigationController?.pushViewController(viewController!, animated: true)
    }
    
    @objc func rightButtonTap(){
        testLabel.text = "Test Right Button"
    }
    
    @IBAction func showAlertTap(_ sender: Any) {
        showAlert()
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: "Alert", message: "This is an alert.", preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: "Default", style: .default) { (action:UIAlertAction) in
            print("You've pressed default");
        }
        
        let action2 = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction) in
            print("You've pressed cancel");
        }
        
        alertController.addAction(action1)
        alertController.addAction(action2)
        self.present(alertController, animated: true, completion: {
            #if DEBUG
            BehaveV2.sharedInstance.track(eventString: .actionSheet)
            #endif
        })
    }
}
