//
//  AddKeywordViewController.swift
//  Blocky
//
//  Created by Nayem BJIT on 4/18/18.
//  Copyright © 2018 BJIT Ltd. All rights reserved.
//

import UIKit

class AddKeywordViewController: UIViewController {
    @IBOutlet private weak var keywordTextField: UITextField!

    var stateController: StateController!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "SaveKeywordSegue" else {
            return
        }
        let word = keywordTextField.text ?? ""
        // save this word to storage using state controller
        stateController.add(word: word)
    }

}
