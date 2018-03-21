//
//  Date+Extension.swift
//  AppBuilder
//
//  Created by Lucio on 11/23/17.
//  Copyright © 2017 Lucio Pham. All rights reserved.
//

import Foundation

extension Date {
    
    func toTimeSinceNowFormat() -> String {
        let components = (Calendar.current as NSCalendar).components([.day, .hour, .minute, .month, .year, .weekday], from: self, to: Date(), options: [])
        if components.year! > 0 {
            return "\(components.year!) năm trước"
        } else if components.month! > 0 {
            return "\(components.month!) tháng trước"
        } else if components.weekday! > 0 {
            return "\(components.weekday!) tuần trước"
        } else if components.day! > 0 {
            return "\(components.day!) ngày trước"
        } else if components.hour! > 0 {
            return "\(components.hour!) giờ trước"
        } else if components.minute! > 0 {
            return "\(components.minute!) phút trước"
        }
        return "Vừa xong"
    }
  
  func loginTime() -> String {
    
    let currentLoginTime = self.toStringFormat8601()
    
    return "ios_\(currentLoginTime)"
    
  }
    
    func checkTomorrowDate() -> String
    {
        return NSCalendar.current.isDateInTomorrow(self) == true ? "Tomorrow".localized() : ""
    }
    
}


extension Date {
  
  func currentDayOfWeek() -> Int  {
    let gregorian = Calendar(identifier: .gregorian)
    return gregorian.dateComponents([.weekday], from: self).weekday ?? 0
  }
  
  public func setTime(hour: Int, min: Int) -> Date? {
    let x: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
    let cal = Calendar.current
    var components = cal.dateComponents(x, from: self)
    
    components.hour = hour
    components.minute = min
    
    return cal.date(from: components)
  }
  
    func isGreaterThanDate(dateToCompare: Date) -> Bool {
        return self.compare(dateToCompare) == ComparisonResult.orderedDescending
    }
    
    func isLessThanDate(dateToCompare: Date) -> Bool {
        return self.compare(dateToCompare) == ComparisonResult.orderedAscending
    }
    
    func equalToDate(dateToCompare: Date) -> Bool {
        return self.compare(dateToCompare) == ComparisonResult.orderedSame
    }
    
    func toStringFormat8601() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.string(from:self)
    }
    
    func toString(format dateFormat: String, timeZone: TimeZone? = nil) -> String {
        let dateFormatter = DateFormatter()
        if(dateFormat == DateFormat.FORMAT_SHORT_DATE_TIME_2)
        {
            dateFormatter.dateStyle = .short
            dateFormatter.dateFormat = dateFormatter.dateFormat.replacingOccurrences(of: "yy", with: "yyyy")
        }else if(dateFormat == DateFormat.FORMAT_SHORT_DATE_TIME)
        {
            dateFormatter.dateStyle = .medium            
        }
            
        else
        {
            dateFormatter.dateFormat = dateFormat
        }
        
        if timeZone != nil { dateFormatter.timeZone = timeZone }
        return dateFormatter.string(from: self)
    }
    
    func toStringInMediumtFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: self)
    }
    
    func formattedFromCompenents(styleAttitude: DateFormatter.Style, year: Bool = false, month: Bool = true, day: Bool = true, hour: Bool = false, minute: Bool = false, second: Bool = false) -> String {
        let long = styleAttitude == .long || styleAttitude == .full
        var comps = ""
        
        if year { comps += long ? "yyyy" : "yy" }
        if month { comps += long ? "MMMM" : "MMM" }
        if day { comps += long ? "dd" : "d" }
        
        if hour { comps += long ? "HH" : "H" }
        if minute { comps += long ? "mm" : "m" }
        if second { comps += long ? "ss" : "s" }
        
        let format = DateFormatter.dateFormat(fromTemplate: comps, options: 0, locale: NSLocale.current)
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}


