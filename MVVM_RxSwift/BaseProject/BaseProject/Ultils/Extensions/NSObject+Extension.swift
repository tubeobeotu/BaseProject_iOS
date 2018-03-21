//
//  NSObject+Extension.swift
//  AB Branded App
//
//  Created by Lucio on 12/18/17.
//  Copyright © 2017 Lucio Pham. All rights reserved.
//

import Foundation

extension NSObject {
    class var nameOfClass: String {
        return NSStringFromClass(self).components(separatedBy: ".").last ?? ""
    }
    
    var nameOfClass: String {
        return NSStringFromClass(type(of: self)).components(separatedBy: ".").last ?? ""
    }
}
