//
//  PhoneNumberParser.swift
//  Blocky
//
//  Created by Nayem BJIT on 5/17/18.
//  Copyright © 2018 BJIT Ltd. All rights reserved.
//

import PhoneNumberKit

class PhoneNumberParser {
    
    static let shared = PhoneNumberKit()
    private init() {
        
    }
}

extension String {
    var internationallyFormattedNumber: String? {
        do {
            let phoneNumber = try PhoneNumberParser.shared.parse(self)
            return PhoneNumberParser.shared.format(phoneNumber, toType: .international)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
