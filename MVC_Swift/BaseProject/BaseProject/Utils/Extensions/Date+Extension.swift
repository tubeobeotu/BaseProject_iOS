//
//  Date+Extension.swift
//

import Foundation

extension Date {
    
    private static func minuteInSeconds() -> Double { return 60 }
    private static func hourInSeconds() -> Double { return 3600 }
    private static func dayInSeconds() -> Double { return 86400 }
    private static func weekInSeconds() -> Double { return 604800 }
    private static func yearInSeconds() -> Double { return 31556926 }
    
    func secondsAfterDate(date: Date) -> Int {
        return Int(self.timeIntervalSince(date))
    }
    
    func secondsBeforeDate(date: Date) -> Int {
        return Int(date.timeIntervalSince(self))
    }
    
    func minutesAfterDate(date: Date) -> Int {
        let interval = self.timeIntervalSince(date)
        return Int(interval / Date.minuteInSeconds())
    }
    
    func minutesBeforeDate(date: Date) -> Int {
        let interval = date.timeIntervalSince(self)
        return Int(interval / Date.minuteInSeconds())
    }
    
    func hoursAfterDate(date: Date) -> Int {
        let interval = self.timeIntervalSince(date)
        return Int(interval / Date.hourInSeconds())
    }
    
    func hoursBeforeDate(date: Date) -> Int {
        let interval = date.timeIntervalSince(self)
        return Int(interval / Date.hourInSeconds())
    }
    
    func daysAfterDate(date: Date) -> Int {
        let interval = self.timeIntervalSince(date)
        return Int(interval / Date.dayInSeconds())
    }
    
    func daysBeforeDate(date: Date) -> Int {
        let interval = date.timeIntervalSince(self)
        return Int(interval / Date.dayInSeconds())
    }
    
    func weeksAfterDate(date: Date) -> Int {
        let interval = self.timeIntervalSince(date)
        return Int(interval / Date.weekInSeconds())
    }
    
    func weeksBeforeDate(date: Date) -> Int {
        let interval = date.timeIntervalSince(self)
        return Int(interval / Date.weekInSeconds())
    }
    
    func yearsAfterDate(date: Date) -> Int {
        let interval = self.timeIntervalSince(date)
        return Int(interval / Date.yearInSeconds())
    }
    
    func yearsBeforeDate(date: Date) -> Int {
        let interval = date.timeIntervalSince(self)
        return Int(interval / Date.yearInSeconds())
    }
    
    func timeIntervalSince1970String() -> String {
        let timeInterval = self.timeIntervalSince1970
        return "\(timeInterval*1000)"
    }
    
    func toString(_ stringFormatter: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = stringFormatter
        return dateFormatter.string(from: self)
    }
	
	func dateByAddingDays(inDays: NSInteger) -> Date {
		return Calendar.current.date(byAdding: .day, value: inDays, to: self)!
	}
}

