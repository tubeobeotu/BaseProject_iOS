//
//  UILabel+Extension.swift
//

import Foundation
import UIKit

extension UILabel {
    
    func componentWithString(_ string: String, font: UIFont, color: UIColor) {
        if let currentString = self.text {
            let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: currentString)
            attributedString.componentWithString(string, font: font, color: color)
            self.attributedText = attributedString
        }
    }
	
	func underline() {
		if let textString = self.text {
			let attributedString = NSMutableAttributedString(string: textString)
			attributedString.addAttribute(NSUnderlineStyleAttributeName, value: NSUnderlineStyle.styleSingle.rawValue, range: NSRange(location: 0, length: attributedString.length - 1))
			attributedText = attributedString
		}
	}
}

