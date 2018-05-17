//
//  Model.swift
//  Blocky
//
//  Created by Nayem on 4/18/18.
//  Copyright © 2018 Mufakkharul Islam Nayem. All rights reserved.
//

import Foundation
import CallKit

struct WordFilter: Codable {
    let words: [String]
}

struct NumberFilter: Codable {
    let numbers: [String]
}

struct CallBlock: Codable, Equatable {
    let name: String
    let phoneNumber: String /* "+880 1768-835619" */
    init(name: String = "Unknown", phoneNumber: String) {
        self.name = name
        self.phoneNumber = phoneNumber
    }
}
