//
//  FilterNumbersTableViewCell.swift
//  Blocky
//
//  Created by Nayem BJIT on 4/19/18.
//  Copyright © 2018 BJIT Ltd. All rights reserved.
//

import UIKit

class FilterNumbersTableViewCell: UITableViewCell {

    var viewModel: ViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            self.textLabel?.text = viewModel.number.internationallyFormattedNumber ?? "Phone Number Malformed"
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

extension FilterNumbersTableViewCell {
    struct ViewModel {
        let number: String
    }
}
