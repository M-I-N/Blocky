//
//  FilterNumbersViewController.swift
//  Blocky
//
//  Created by Nayem on 4/19/18.
//  Copyright © 2018 Mufakkharul Islam Nayem. All rights reserved.
//

import UIKit

class FilterNumbersViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!

    var stateController: StateController!
    private var dataSource: FilterNumbersTableViewDataSource!
    
    lazy var numberListItemDeletionClosure: ((String) -> Void) = { [weak self] number in
        // delete from state controller
        self?.stateController.delete(number: number)
        self?.tableView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataSource = FilterNumbersTableViewDataSource(numbers: stateController.numbers, itemDeletionObserver: numberListItemDeletionClosure)
        tableView.dataSource = dataSource
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "AddNumberSegue":
            if let navigationController = segue.destination as? UINavigationController, let addNumberViewController = navigationController.viewControllers.first as? AddNumberViewController {
                addNumberViewController.stateController = stateController
            }
        default:
            break
        }
    }

    @IBAction func cancelAddNumber(_ segue: UIStoryboardSegue) {}
    @IBAction func saveNumber(_ segue: UIStoryboardSegue) {}

}
