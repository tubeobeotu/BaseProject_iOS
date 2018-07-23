//
//  Dictionary+Extension.swift
//

import Foundation

extension Dictionary {
    
    func toString() -> String {
        do {
            let data = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            if let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                return json as String
            }
            
            return ""
        } catch {
            return ""
        }
    }
}
