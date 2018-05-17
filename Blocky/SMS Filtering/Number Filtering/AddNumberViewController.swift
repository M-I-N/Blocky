//
//  AddNumberViewController.swift
//  Blocky
//
//  Created by Nayem on 4/19/18.
//  Copyright © 2018 Mufakkharul Islam Nayem. All rights reserved.
//

import UIKit
import CTKFlagPhoneNumber

class AddNumberViewController: UIViewController {
    @IBOutlet private weak var phoneNumberTextField: CTKFlagPhoneNumberTextField!

    var stateController: StateController!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCountryCodeTextField()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    private func setupCountryCodeTextField() {
        phoneNumberTextField.parentViewController = self
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "SaveNumberSegue" else {
            return
        }
        let number = phoneNumberTextField.getFormattedPhoneNumber()
        // save this word to storage using state controller
        if let number = number {
            stateController.add(number: number)
        }
    }

}
