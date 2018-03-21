//
//  String+Extension.swift
//

import Foundation
import UIKit
extension String {
    
    func toDictionary() -> [String: AnyObject]? {
        if let data = self.data(using: String.Encoding.utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject]
            } catch let error as NSError {
                print(error)
            }
        }
        return nil
    }
    
    func toInt() -> Int {
        if let value = Int(self) {
            return value
        }
        return 0
    }
    
    func toFloat() -> Float {
        if let value = Float(self) {
            return value
        }
        return 0
    }
    
    func toDouble() -> Double {
        if let value = Double(self) {
            return value
        }
        return 0.0
    }
    
    func toBool() -> Bool {
        switch self.lowercased() {
        case "success", "true", "yes", "1":
            return true
        default:
            return false
        }
    }
    
    func toDate() -> Date {
        return Date(timeIntervalSince1970: TimeInterval(atof(self)/1000))
    }
    
    func toDateWithFormat(_ format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }
    
    func fromBase64String() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
    
    func toBase64String() -> String {
        return Data(self.utf8).base64EncodedString()
    }
    
    func isValidEmail() -> Bool {
        let characters = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let email = NSPredicate(format:"SELF MATCHES %@", characters)
        return email.evaluate(with: self)
    }
    
    func isValidIPAddress() -> Bool {
        let parts = self.components(separatedBy: ".")
        let nums = parts.flatMap { Int($0) }
        return parts.count == 4 && nums.count == 4 && nums.filter { $0 >= 0 && $0 < 256}.count == 4
    }
    
    //MARK: - trim Trailing and leading whitespace
    func stringByTrimmingLeadingAndTrailingWhitespace() -> String {
        let leadingAndTrailingWhitespacePattern = "(?:^\\s+)|(?:\\s+$)"
        return self.replacingOccurrences(of: leadingAndTrailingWhitespacePattern, with: "", options: .regularExpression)
    }
}

//Random string
extension String {
    static func random(length: Int = 20) -> String {
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString: String = ""
        
        for _ in 0..<length {
            let randomValue = arc4random_uniform(UInt32(base.characters.count))
            randomString += "\(base[base.index(base.startIndex, offsetBy: Int(randomValue))])"
        }
        return randomString
    }
}
extension String {
    var htmlAttributedString: NSAttributedString? {
            do {
                let data = try NSAttributedString(data: Data(utf8), options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue], documentAttributes: nil)
                return data
            } catch {
                print("error:", error)
                return nil
            }
    }
    var htmlString: String {
        return htmlAttributedString?.string ?? ""
    }
    var stringByRemovingWhitespaceAndNewlineCharacterSet: String {
        return components(separatedBy: .newlines).joined(separator: "")
    }
    var stringByRemovingWhitespace: String {
        return components(separatedBy: " ").joined(separator: "")
    }
    
    func toCurrentTimeZoneDateWithFormat(_ format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.date(from: self)
    }
}
extension String
{
    func localizedString() -> String
    {
        return NSLocalizedString(self, comment: "")
    }
    func isValidString() -> Bool
    {
        if(components(separatedBy: .whitespacesAndNewlines).joined() == "")
        {
            return false
        }
        return true
    }
}

extension String
{
    func length() -> Int
    {
        if let newString = self as? String {
            return newString.characters.count
        }
        return 0
    }
}

extension String
{
    func sTrimString() -> String
    {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
