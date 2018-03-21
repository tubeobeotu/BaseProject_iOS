//
//  UITextField+Extension.swift
//  AB Branded App
//
//  Created by TH on 12/18/17.
//  Copyright © 2017 Lucio Pham. All rights reserved.
//

import Foundation

extension UITextField {
    
    func applyVerificationStyle() {
        self.font = AppFont.regular(fontSize: 33).font
        self.border = 1
        self.cornerRadius = 4
        self.borderColor = UIColor.white
        self.backgroundColor = UIColor.clear
    }
}

