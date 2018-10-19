//
//  PublicFunc.swift
//  MBH
//
//  Created by tunv on 7/25/18.
//  Copyright © 2018 tunv. All rights reserved.
//

import Foundation
public func print(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    if(Constant.DEBUG_MODE == true){
        let output = items.map { "\($0)" }.joined(separator: separator)
        Swift.print(output, terminator: terminator)
    }
}
