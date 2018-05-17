//
//  BlockedListTableViewDataSource.swift
//  Blocky
//
//  Created by Nayem BJIT on 5/15/18.
//  Copyright © 2018 BJIT Ltd. All rights reserved.
//

import UIKit

class BlockedListTableViewDataSource: NSObject {
    private(set) var callBlocks: [CallBlock]
    let itemDeletionObserver: ((CallBlock) -> Void)?
    init(callBlocks: [CallBlock], itemDeletionObserver: ((CallBlock) -> Void)? = nil) {
        self.callBlocks = callBlocks
        self.itemDeletionObserver = itemDeletionObserver
    }
}

extension BlockedListTableViewDataSource: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return callBlocks.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = String(describing: BlockedListTableViewCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! BlockedListTableViewCell
        let callBlock = callBlocks[indexPath.row]
        cell.viewModel = BlockedListTableViewCell.ViewModel(callBlock: callBlock)
        return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Find the item that needs to be deleted
            let callBlock = callBlocks[indexPath.row]
            if let callBlockIndexToDelete = callBlocks.index(of: callBlock) {
                // First delete it from the local array
                callBlocks.remove(at: callBlockIndexToDelete)
                // This item needs to be deleted from the application state, through StorageController
                itemDeletionObserver?(callBlock)
            }
        }
    }
}
