//
//  Int+Extensions.swift
//  adam-calc
//
//  Created by Adam Reed on 1/21/19.
//  Copyright © 2019 rdConcepts. All rights reserved.
//

import Foundation

extension Integer {
    var formattedWithSeperator: String {
        return Formatter.withSeperator.string(for: self) ?? ""
    }
}
