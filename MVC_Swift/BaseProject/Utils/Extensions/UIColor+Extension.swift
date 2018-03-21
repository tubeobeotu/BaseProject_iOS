//
//  UIColor+Extension.swift
//

import Foundation
import UIKit

extension UIColor {
    
    static func colorWithHexString(_ hexString: String, alpha: CGFloat = 1) -> UIColor {
        let r, g, b: CGFloat
        
        if hexString.hasPrefix("#") {
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            let hexColor = hexString.substring(from: start)
            
            if hexColor.characters.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt32 = 0
                
                if scanner.scanHexInt32(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                    g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                    b = CGFloat((hexNumber & 0x0000ff) >> 0) / 255
                    
                    return UIColor(red: r, green: g, blue: b, alpha: alpha)
                }
            }
        }

        return UIColor.clear
    }
}
