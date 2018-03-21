//
//  String+Extension.swift
//  AppBuilder
//
//  Created by Lucio on 11/23/17.
//  Copyright © 2017 Lucio Pham. All rights reserved.
//

import Foundation

extension String {
    
    // MARK: multiple language
    
    func localizedWithFormat() -> String {
        let str =  String.localizedStringWithFormat(
            NSLocalizedString(self,
                              comment: ""))
        return str
    }
    
    func localized(withComment comment:String, input value: CVarArg) -> String {
        let str =  String.localizedStringWithFormat(
            NSLocalizedString(self,
                              comment: comment),
            value)
        return str
    }
    
    func localized(multipleInput values: CVarArg...) -> String {
        let str =  String.localizedStringWithFormat(
            NSLocalizedString(self,
                              comment: ""),
            values)
        return str
    }
    
    func localized(withComment comment:String) -> String {
        let str =  String.localizedStringWithFormat(
            NSLocalizedString(self,
                              comment: comment))
        return str
    }
    
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
        
    }
    
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
    
    func removeVietnameseDiacredicalMarks() -> String {
        var newString = self
        newString = newString.lowercased()
        let a: [String] = ["á", "à", "ả", "ã", "ạ", "â", "ấ", "ẫ", "ầ", "ẩ", "ậ", "ẩ", "ắ", "ằ", "ẳ", "ẵ", "ặ"]
        let d: String = "đ"
        let e: [String] = ["é", "è", "ẻ", "ẽ", "ẹ", "ê", "ế", "ề", "ể", "ễ", "ệ"]
        let i: [String] = ["í", "ỉ", "ị", "ì", "ĩ"]
        let o: [String] = ["ó", "ò", "ỏ", "ó", "ọ", "ô", "ố", "ồ", "ổ", "ỗ", "ộ", "ơ", "ớ", "ờ", "ở", "ỡ", "ợ"]
        let u: [String] = ["ú", "ù", "ủ", "ũ", "ụ", "ư", "ứ", "ừ", "ử", "ữ", "ự"]
        let y: [String] = ["ý", "ỳ", "ỷ", "ỹ", "ỵ"]
        
        for c in a {
            newString = newString.replacingOccurrences(of: c, with: "a")
        }
        
        newString = newString.replacingOccurrences(of: d, with: "d")
        
        for c in e {
            newString = newString.replacingOccurrences(of: c, with: "e")
        }
        
        for c in i {
            newString = newString.replacingOccurrences(of: c, with: "i")
        }
        
        for c in o {
            newString = newString.replacingOccurrences(of: c, with: "o")
        }
        
        for c in u {
            newString = newString.replacingOccurrences(of: c, with: "u")
        }
        
        for c in y {
            newString = newString.replacingOccurrences(of: c, with: "y")
        }
        
        return newString
    }
    
    func tagString() -> String {
        var str = self.removeVietnameseDiacredicalMarks()
        str = str.replacingOccurrences(of: " ", with: "")
        str = "@" + str
        return str
    }
    
    func isValidEmail() -> Bool {
        let regex = try? NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex?.firstMatch(in: self, options: [], range: NSMakeRange(0, self.count)) != nil
    }
    
    func isAlphanumeric() -> Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
    
    func isValidPhonenumber() -> Bool
    {
        let phone_regex = "[0-9'@s]{9,}$"
        //        let phone_regex = "^09[0-9'@s]{8,}$"
        //        let phone_regex2 = "^9[0-9'@s]{8,}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phone_regex)
        //        let phoneTest2 = NSPredicate(format: "SELF MATCHES %@", phone_regex2)
        let result =  phoneTest.evaluate(with: self)
        //            || phoneTest2.evaluate(with: self)
        return result
    }
    //validate Password
    func isValidPassword() -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^[a-zA-Z_0-9\\-_,;.:#+*?=!§$%&/()@]+$", options: .caseInsensitive)
            if(regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil){
                
                if(self.count >= 6 && self.count <= 20){
                    return true
                }else{
                    return false
                }
            }else{
                return false
            }
        } catch {
            return false
        }
    }
    func sizeOf_String( font: UIFont) -> CGSize {
        let fontAttribute = [NSAttributedStringKey.font: font]
        let size = self.size(withAttributes: fontAttribute)  // for Single Line
        return size;
    }
}
extension String
{
    func toDateFormat8601() -> Date? {
        let dateFormatter = DateFormatter()
        //                                  2017-12-17T23:15:56-05:00
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        //dateFormatter.timeZone = TimeZone.current
        return dateFormatter.date(from: self)
    }
    
}
extension String
{
    func isValidedString() -> Bool
    {
        if(self.trimmingCharacters(in: .whitespacesAndNewlines).count > 0)
        {
            return true
        }
        return false
    }
    
    func stringByRemovingWhitespaceAndNewlineCharacterSet() -> String {
        return self.components(separatedBy: NSCharacterSet.whitespacesAndNewlines).joined(separator: "")
    }
    
    func convertToLatinCharacters() -> String
    {
        let temp = self.data(using: .ascii, allowLossyConversion: true)
        if let result = String(data: temp!, encoding: .ascii)
        {
            return result
        }
        return ""
    }
    func underline(color: UIColor) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        let range = NSRange(location: 0, length: attributedString.length)
        attributedString.addAttribute(NSAttributedStringKey.underlineStyle, value: NSUnderlineStyle.styleSingle.rawValue, range: range)
        attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: color , range: range)
        return attributedString
    }
    func getYear() -> String
    {
        let indexStartOfText = self.index(self.endIndex, offsetBy: -2)
        return String(self[indexStartOfText...])
    }
}


extension String: Error {}/*Enables you to throw a string*/

extension String: LocalizedError {/*Adds error.localizedDescription to Error instances*/
    public var errorDescription: String? { return self }
}

