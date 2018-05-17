//
//  ViewController.swift
//  Blocky
//
//  Created by Nayem BJIT on 4/17/18.
//  Copyright © 2018 BJIT Ltd. All rights reserved.
//

import UIKit

class FilterWordsViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!

    var stateController: StateController!
    private var dataSource: FilterWordsTableViewDataSource!
    
    lazy var wordListItemDeletionClosure: ((String) -> Void) = { [weak self] word in
        // delete from state controller
        self?.stateController.delete(word: word)
        self?.tableView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataSource = FilterWordsTableViewDataSource(words: stateController.words, itemDeletionObserver: wordListItemDeletionClosure)
        tableView.dataSource = dataSource
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "AddKeywordsSegue":
            if let navigationController = segue.destination as? UINavigationController, let addKeywordViewController = navigationController.viewControllers.first as? AddKeywordViewController {
                addKeywordViewController.stateController = stateController
            }
        default:
            break
        }
    }

    @IBAction func cancelAddKeyword(_ segue: UIStoryboardSegue) {}
    @IBAction func saveKeyword(_ segue: UIStoryboardSegue) {}

}

