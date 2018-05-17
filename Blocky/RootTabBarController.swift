//
//  RootTabBarController.swift
//  Blocky
//
//  Created by Nayem BJIT on 5/15/18.
//  Copyright © 2018 BJIT Ltd. All rights reserved.
//

import UIKit

class RootTabBarController: UITabBarController {

    var stateController: StateController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers?.forEach({ (viewController) in
            guard let navigationController = viewController as? UINavigationController else { return }
            if let masterViewController = navigationController.viewControllers.first as? MasterViewController {
                masterViewController.stateController = stateController
            }
            if let blockedListTableViewController = navigationController.viewControllers.first as? BlockedListTableViewController {
                blockedListTableViewController.stateController = stateController
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
