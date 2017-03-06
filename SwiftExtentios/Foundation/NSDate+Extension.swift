//
//  Date+Extension.swift
//  SwiftExtentios
//
//  Created by Phani on 06/03/17.
//  Copyright © 2017 mobileways. All rights reserved.
//

import Foundation

let kMinute = 60
let kDay = kMinute * 24
let kWeek = kDay * 7
let kMonth = kDay * 31
let kYear = kDay * 365

extension Date {
    
    // MARK:- ---> Components
    
    private static func componentFlags() -> Set<Calendar.Component> { return [.year, .month, .day, .weekOfYear, .hour, .minute, .second, .weekday, .weekdayOrdinal, .weekOfYear] }
    
//    let unitFlags = Set<Calendar.Component>([.hour, .year, .minute])
//    calendar.timeZone = TimeZone(identifier: "UTC")!

    private static func components(fromDate: Date) -> DateComponents? {
        return Calendar.current.dateComponents(componentFlags(), from: fromDate)
    }
    
    private func components() -> DateComponents?  {
        return Date.components(fromDate: self)
    }
    
    func getCompoents() -> DateComponents? {
        return self.components()
    }
    
    
    /**
     Returns the year component.
     
     :returns: Int
     */
    func year () -> Int? { return self.components()?.year  }
    /**
     Returns the month component.
     
     :returns: Int
     */
    func month () -> Int? { return self.components()?.month }
    
    func hour () -> Int? { return self.components()?.hour }
    
    // MARK:- ---> Adjusting Dates
    
    func epoch_seconds(_ isGMT: Bool = false) -> Double {
        let date = isGMT ? self.GMT() : self
        let seconds = date.timeIntervalSince1970
        return seconds
    }
    
    func epoch_milliSeconds(_ isGMT: Bool = false) -> Double {
        let date = isGMT ? self.GMT() : self
        return date.timeIntervalSince1970 * 1000
    }
    func epoch_milliSecondsAsString(_ isGMT: Bool = false) -> String? {
        let date = isGMT ? self.GMT() : self
        return (date.timeIntervalSince1970 * 1000).toStr
    }
    
    func GMT() -> Date {
        let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: self))
        return self.addingTimeInterval(-timeZoneOffset)
    }
    
    func localTime() -> Date {
        let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: self))
        return self.addingTimeInterval(timeZoneOffset)
    }
    
    /**
     Returns a new Date object by a adding years.
     
     :param: days :Int Years to add.
     :returns: Date
     */
    func dateByAddingYears(years: Int) -> Date? {
        var dateComp = DateComponents()
        dateComp.year = years

        return Calendar.current.date(byAdding: dateComp , to: self)
    }
    
    /**
     Returns a new Date object by a substracting years.
     
     :param: days :Int Years to substract.
     :returns: Date
     */
    func dateBySubtractingYears(years: Int) -> Date?
    {
        var dateComp = DateComponents()
        dateComp.year = (years * -1)
        return Calendar.current.date(byAdding: dateComp , to: self)

    }
    
    /**
     Returns a new Date object by a adding days.
     
     :param: days :Int Days to add.
     :returns: Date
     */
    func dateByAddingDays(days: Int) -> Date? {
        var dateComp = DateComponents()
        dateComp.day = days
        return Calendar.current.date(byAdding: dateComp, to: self)
    }
    
    /**
     Returns a new Date object by a adding minutes.
     
     :param: days :Int Minutes to add.
     :returns: Date
     */
    func dateByAddingMinutes(minutes: Int) -> Date? {
        var dateComp = DateComponents()
        dateComp.minute = minutes
        
        return Calendar.current.date(byAdding: dateComp ,to: self)

    }
    
    func dateByAddingMonths(months: Int) -> Date {
        return Calendar.current.date(byAdding: .month, value: months, to: self as Date)!
    }
  
    func dateStringFromDate(date: Date) -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd'th 'MMM' at 'h:mm a"
        
        return dateFormatterPrint.string(from: date as Date) as String
    }
    
    
    
    
    
  
      // MARK: Adjusting Dates <---
    
    func epoch(isMilliSeconds: Bool = false) -> Double {
        return (self.timeIntervalSince1970) * (isMilliSeconds ? 1000 : 1)
    }
    
    // MARK:- ---> To String
    
    // shows 1 or two letter abbreviation for units.
    // does not include 'ago' text ... just {value}{unit-abbreviation}
    // does not include interim summary options such as 'Just now'
    var timeAgoSimple: String {
        
        let now = Date()
        let deltaSeconds = Int(fabs(now.timeIntervalSince(self.localTime())))
        let deltaMinutes = deltaSeconds / 60
        
        var value: Int!
        
        if deltaSeconds < kMinute {
            // Seconds
            return String(format:"%ds", deltaSeconds)
        } else if deltaMinutes < kMinute {
            // Minutes
            return String(format:"%dm",  deltaMinutes)
        } else if deltaMinutes < kDay {
            // Hours
            value = Int(floor(Float(deltaMinutes / kMinute)))
            return String(format:"%dh",  value)
        } else if deltaMinutes < kWeek {
            // Days
            value = Int(floor(Float(deltaMinutes / kDay)))
            return String(format:"%dd",  value)
        } else if deltaMinutes < kMonth {
            // Weeks
            value = Int(floor(Float(deltaMinutes / kWeek)))
            return String(format:"%dw",  value)
        } else if deltaMinutes < kYear {
            // Month
           
            let dateComponents = Calendar.current.dateComponents([.month], from: self, to: Date())
            
            
            return String(format:"%dmo",  dateComponents.month ?? 0)
        }
        
        // Years
        value = Int(floor(Float(deltaMinutes / kYear)))
        return String(format:"%dyr",  value)
    }
    
    func timeAgoTemp(date: Date) -> String {
        
        let now = Date()
        let deltaSeconds = Int(fabs(now.timeIntervalSince(self.localTime())))
        
        let deltaMinutes = deltaSeconds / 60
        
        var value: Int!
        
        if deltaSeconds < kMinute {
            // Seconds
            return String(format:"%ds", deltaSeconds)
        } else if deltaMinutes < kMinute {
            // Minutes
            return String(format:"%dm",  deltaMinutes)
        } else if deltaMinutes < kDay {
            // Hours
            value = Int(floor(Float(deltaMinutes / kMinute)))
            return String(format:"%dh",  value)
        } else if deltaMinutes < kYear {
            // Month
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "MMM dd"
            
            //            print("date formatter:---------\(dateFormatterPrint.stringFromDate(date) as String)")
            return "\(dateFormatterPrint.string(from: date as Date) as String)"
        }
       
        //Years
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "yyyy"
        
        //            print("date formatter:---------\(dateFormatterPrint.stringFromDate(date) as String)")
        return "\(dateFormatterPrint.string(from: date as Date) as String)"

    }
    
    func yearFromDate(date: Date) -> String {
        let now = Date()
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "yyyy"
        
        print("DatePosted:---------\(dateFormatterPrint.string(from: date as Date) as String)")
        print("DateNow:---------\(dateFormatterPrint.string(from: now as Date) as String)")
        
        if dateFormatterPrint.string(from: date as Date) as String != dateFormatterPrint.string(from: now as Date) as String {
            return dateFormatterPrint.string(from: date as Date) as String
        } else {
            return ""
        }
    }
    
    
    
    var timeAgo: String {
        
        let now = Date()
        let deltaSeconds = Int(fabs(now.timeIntervalSince(self.localTime())))
        let deltaMinutes = deltaSeconds / 60
        
        var value: Int!
        
        if deltaSeconds < 5 {
            // Just Now
            return "Just now"
        } else if deltaSeconds < kMinute {
            // Seconds Ago
            return String(format:"Just now",  deltaSeconds)
        } else if deltaSeconds < 120 {
            // A Minute Ago
            return "a minute ago"
        } else if deltaMinutes < kMinute {
            // Minutes Ago
            return String(format:"%d minutes ago",  deltaMinutes)
        } else if deltaMinutes < 120 {
            // An Hour Ago
            return "an hour ago"
        } else if deltaMinutes < kDay {
            // Hours Ago
            value = Int(floor(Float(deltaMinutes / kMinute)))
            return String(format:"%d hours ago",  value)
        } else if deltaMinutes < (kDay * 2) {
            // Yesterday
            return "a day ago"
        } else if deltaMinutes < kMonth {
            // Days Ago
            value = Int(floor(Float(deltaMinutes / kDay)))
            return String(format:"%d days ago",  value)
        } else if deltaMinutes < (kDay * 61) {
            // Last month
            return "a month ago"
        } else if deltaMinutes < kYear {
            // Month Ago
            //value = Int(floor(Float(deltaMinutes / kMonth)))
            let dateComponents = Calendar.current.dateComponents([.month], from: self, to: Date())

            return String(format:"%d months ago",  dateComponents.month ?? 0)
        } else if deltaMinutes < (kDay * (kYear * 2)) {
            // Last Year
            return "an year ago"
        }
        
        // Years Ago
        value = Int(floor(Float(deltaMinutes / kYear)))
        return String(format:"%d years ago",  value)
        
    }
    
    func string(format: String = "dd MMM yyyy hh:mm:ss a") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return (formatter.string(from: self))
    }
    
    // MARK: To String <---
    
    
    func offsetFrom(date:Date) -> String {
        
        let comp = Calendar.current.dateComponents([.day, .hour, .minute], from: date as Date, to: self)
        
        let daysFromDate    = comp.day
        let hoursFromDate   = comp.hour
        let minutesFromDate = comp.minute
        
        var difference:String = ""
                
        if daysFromDate! > 0 {
            difference += "\(daysFromDate) day"
            difference += (daysFromDate! > 1) ? "s ": " "
        }
        
        if (hoursFromDate! > 0 || minutesFromDate! > 0) {
            difference += "\(hoursFromDate)"
            if minutesFromDate! > 0{ difference += ".5" }
            difference += " hour" + ((hoursFromDate == 1 && minutesFromDate == 0) ? "":"s")
        }
        
        return difference
    }
    
    func roundedDaysOffsetFrom(date:Date) -> Int {
        
        let comp = Calendar.current.dateComponents([.day, .hour, .minute], from: date, to: self)
        
        var daysFromDate    = comp.day
        let hoursFromDate   = comp.hour
        let minutesFromDate = comp.minute
        
        if (hoursFromDate! > 0 || minutesFromDate! > 0) {
            daysFromDate! += 1
        }
        
        return daysFromDate!
    }
    
    
}




