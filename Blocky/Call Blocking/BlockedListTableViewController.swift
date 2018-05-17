//
//  BlockedListTableViewController.swift
//  Blocky
//
//  Created by Nayem BJIT on 5/15/18.
//  Copyright © 2018 BJIT Ltd. All rights reserved.
//

import UIKit
import CallKit

class BlockedListTableViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!

    var stateController: StateController!
    private var dataSource: BlockedListTableViewDataSource!

    override func viewDidLoad() {
        super.viewDidLoad()
        CXCallDirectoryManager.sharedInstance.getEnabledStatusForExtension(withIdentifier: Constants.callDirectoryExtensionIdentifier) { [weak self] (status, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                switch status {
                case .unknown, .disabled:
                    self?.showAlertToEnableCallblockingFeature()
                default:
                    break
                }
            }
        }
    }
    
    lazy var blockedListItemDeletionClosure: ((CallBlock) -> Void) = { [weak self] callBlock in
        // delete from state controller
        self?.stateController.delete(callblock: callBlock)
        self?.tableView.reloadData()
        self?.reloadCallDirectoryExtension()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataSource = BlockedListTableViewDataSource(callBlocks: stateController.callBlocks, itemDeletionObserver: blockedListItemDeletionClosure)
        tableView.dataSource = dataSource
        tableView.reloadData()

        CXCallDirectoryManager.sharedInstance.getEnabledStatusForExtension(withIdentifier: Constants.callDirectoryExtensionIdentifier) { [weak self] (status, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                switch status {
                case .enabled:
                    self?.reloadCallDirectoryExtension()
                default:
                    break
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "AddBlockingNumberSegue":
            if let navigationController = segue.destination as? UINavigationController, let addBlockNumberViewController = navigationController.viewControllers.first as? AddBlockNumberViewController {
                addBlockNumberViewController.stateController = stateController
            }
        default:
            break
        }
    }

    @IBAction func cancelAddBlockingNumber(_ segue: UIStoryboardSegue) {}
    @IBAction func saveBlockingNumber(_ segue: UIStoryboardSegue) {}

    private func showAlertToEnableCallblockingFeature() {
        let alertController = UIAlertController(title: "Enable Call Blocking Feature", message: "Go-to Settings->Phone->Call Blocking & Identification->Turn On \"Block & Filter\"", preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { [unowned self] (action) in
            self.openCallBlockingSettings()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(settingsAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }

    private func reloadCallDirectoryExtension() {
        CXCallDirectoryManager.sharedInstance.reloadExtension(withIdentifier: Constants.callDirectoryExtensionIdentifier) { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }

    private func openCallBlockingSettings() {
        do {
            try PreferencesExplorer.open(.phone)
        } catch {
            print(error.localizedDescription)
        }
    }
}
