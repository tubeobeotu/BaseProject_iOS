//
//  Optional+Extension.swift
//  AppBuilder
//
//  Created by Lucio on 11/23/17.
//  Copyright © 2017 Lucio Pham. All rights reserved.
//

import Foundation

extension Optional where Wrapped == String {
    var nilIfEmpty: String? {
        guard let strongSelf = self else { return nil }
        
        return strongSelf.isEmpty ? nil : strongSelf
    }
}
