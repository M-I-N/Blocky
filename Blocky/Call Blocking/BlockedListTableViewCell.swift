//
//  BlockedListTableViewCell.swift
//  Blocky
//
//  Created by Nayem BJIT on 5/15/18.
//  Copyright © 2018 BJIT Ltd. All rights reserved.
//

import UIKit

class BlockedListTableViewCell: UITableViewCell {

    var viewModel: ViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            self.textLabel?.text = viewModel.name
            self.detailTextLabel?.text = viewModel.phoneNumber.internationallyFormattedNumber ?? "Phone Number Malformed"
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension BlockedListTableViewCell {
    struct ViewModel {
        let name: String
        let phoneNumber: String
    }
}

extension BlockedListTableViewCell.ViewModel {
    init(callBlock: CallBlock) {
        name = callBlock.name
        phoneNumber = String(callBlock.phoneNumber)
    }
}
