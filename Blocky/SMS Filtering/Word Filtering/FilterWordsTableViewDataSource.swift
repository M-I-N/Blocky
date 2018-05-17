//
//  FilterWordsTableViewDataSource.swift
//  Blocky
//
//  Created by Nayem BJIT on 4/18/18.
//  Copyright © 2018 BJIT Ltd. All rights reserved.
//

import UIKit

class FilterWordsTableViewDataSource: NSObject {
    private(set) var words: [String]
    let itemDeletionObserver: ((String) -> Void)?
    init(words: [String], itemDeletionObserver: ((String) -> Void)? = nil) {
        self.words = words
        self.itemDeletionObserver = itemDeletionObserver
    }
}

extension FilterWordsTableViewDataSource: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = String(describing: FilterWordsTableViewCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! FilterWordsTableViewCell
        let word = words[indexPath.row]
        cell.viewModel = FilterWordsTableViewCell.ViewModel(word: word)
        return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let word = words[indexPath.row]
            if let wordIndexToDelete = words.index(of: word) {
                words.remove(at: wordIndexToDelete)
                itemDeletionObserver?(word)
            }
        }
    }
}
