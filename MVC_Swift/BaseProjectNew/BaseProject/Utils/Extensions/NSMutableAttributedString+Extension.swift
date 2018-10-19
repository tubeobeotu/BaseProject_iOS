//
//  NSMutableAttributedString+Extension.swift
//

import Foundation
import UIKit

extension NSMutableAttributedString {
    
    func componentWithString(_ string: String, font: UIFont, color: UIColor) {
        let range = self.mutableString.range(of: string, options: .caseInsensitive)
        if range.location != NSNotFound {
            self.addAttributes([NSAttributedStringKey.font: font, NSAttributedStringKey.foregroundColor: color], range: range)
        }
    }
}
