//
//  Formatter+Extensions.swift
//  adam-calc
//
//  Created by Adam Reed on 1/21/19.
//  Copyright © 2019 rdConcepts. All rights reserved.
//

import Foundation

extension Formatter {
    static let withSeperator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = " "
        formatter.numberStyle = .decimal
        return formatter
    }()
}
