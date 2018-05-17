//
//  FilterNumbersTableViewDataSource.swift
//  Blocky
//
//  Created by Nayem BJIT on 4/19/18.
//  Copyright © 2018 BJIT Ltd. All rights reserved.
//

import UIKit

class FilterNumbersTableViewDataSource: NSObject {
    private(set) var numbers: [String]
    let itemDeletionObserver: ((String) -> Void)?
    init(numbers: [String], itemDeletionObserver: ((String) -> Void)? = nil) {
        self.numbers = numbers
        self.itemDeletionObserver = itemDeletionObserver
    }
}

extension FilterNumbersTableViewDataSource: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numbers.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = String(describing: FilterNumbersTableViewCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! FilterNumbersTableViewCell
        let number = numbers[indexPath.row]
        cell.viewModel = FilterNumbersTableViewCell.ViewModel(number: number)
        return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Find the item that needs to be deleted
            let number = numbers[indexPath.row]
            if let numberIndexToDelete = numbers.index(of: number) {
                // First delete it from the local array
                numbers.remove(at: numberIndexToDelete)
                // This item needs to be deleted from the application state, through StorageController
                itemDeletionObserver?(number)
            }
        }
    }
}
