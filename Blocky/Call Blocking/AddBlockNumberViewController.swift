//
//  AddBlockNumberViewController.swift
//  Blocky
//
//  Created by Nayem BJIT on 5/15/18.
//  Copyright © 2018 BJIT Ltd. All rights reserved.
//

import UIKit
import CallKit
import CTKFlagPhoneNumber

class AddBlockNumberViewController: UIViewController {
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var phoneNumberTextField: CTKFlagPhoneNumberTextField!

    var stateController: StateController!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCountryCodeTextField()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    private func setupCountryCodeTextField() {
        phoneNumberTextField.parentViewController = self
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "SaveBlockingNumberSegue" else {
            return
        }
        let name = nameTextField.text ?? ""
        let phoneNumber = phoneNumberTextField.getFormattedPhoneNumber()
        if let phoneNumber = phoneNumber {
            var callBlock: CallBlock
            if name.isEmpty {
                callBlock = CallBlock(phoneNumber: phoneNumber)
            } else {
                callBlock = CallBlock(name: name, phoneNumber: phoneNumber)
            }
            stateController.add(callBlock: callBlock)
        }
    }

}
