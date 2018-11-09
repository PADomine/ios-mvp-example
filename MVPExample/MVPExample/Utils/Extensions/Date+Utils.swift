//
//  Date+Utils.swift
//  MVPExample
//
//  Created by Pablo Dominé on 10/25/17.
//  Copyright © 2017 Lateral View. All rights reserved.
//

import Foundation

extension Date {

    static let kOneDayInMilliseconds: Int64 = 24 * kOneHourInMilliseconds
    static let kOneHourInMilliseconds: Int64 = 60 * kOneMinuteInMilliseconds
    static let kOneMinuteInMilliseconds: Int64 = 60 * 1000
    
    var millisecondsSince1970: Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }

    init(milliseconds: Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds / 1000))
    }

    func isGreaterThanDate(dateToCompare: Date) -> Bool {
        return self.compare(dateToCompare) == .orderedDescending
    }

    func isLessThanDate(dateToCompare: Date) -> Bool {
        return self.compare(dateToCompare) == .orderedAscending
    }

    func equalToDate(dateToCompare: Date) -> Bool {
        return self.compare(dateToCompare) == .orderedSame
    }

    func add(component: Calendar.Component, unitsToAdd: Int) -> Date {
        return Calendar.current.date(byAdding: component, value: unitsToAdd, to: self)!
    }

    func substract(component: Calendar.Component, unitsToAdd: Int) -> Date {
        return Calendar.current.date(byAdding: component, value: -unitsToAdd, to: self)!
    }

    enum DateFormatType {
        case time12hour
        case timeHours12hour
        case dayName
    }

    func toString(with format: DateFormatType) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short

        switch format {
        case .time12hour:
            dateFormatter.dateFormat = "h:mma"
            dateFormatter.amSymbol = "am"
            dateFormatter.pmSymbol = "pm"
        case .timeHours12hour:
            dateFormatter.dateFormat = "ha"
            dateFormatter.amSymbol = "am"
            dateFormatter.pmSymbol = "pm"
        case .dayName:
            dateFormatter.dateFormat = "EEE"
        }

        return dateFormatter.string(from: self)
    }

    func isBetween(_ date1: Date, and date2: Date) -> Bool {
        return (min(date1, date2) ... max(date1, date2)).contains(self)
    }

    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    /// Returns the amount of nanoseconds from another date
    func nanoseconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.nanosecond], from: date, to: self).nanosecond ?? 0
    }
    /// Returns the a custom time interval description from another date
    func offset(from date: Date) -> String {
        if years(from: date)   > 0 { return "\(years(from: date))y"   }
        if months(from: date)  > 0 { return "\(months(from: date))M"  }
        if weeks(from: date)   > 0 { return "\(weeks(from: date))w"   }
        if days(from: date)    > 0 { return "\(days(from: date))d"    }
        if hours(from: date)   > 0 { return "\(hours(from: date))h"   }
        if minutes(from: date) > 0 { return "\(minutes(from: date))m" }
        if seconds(from: date) > 0 { return "\(seconds(from: date))s" }
        if nanoseconds(from: date) > 0 { return "\(nanoseconds(from: date))ns" }
        return ""
    }
    
    // MARK: - Previous Agenda Date extension
    
    // GLOBAL DATETIME NONUTC PATTERN
    static func dateFormatterForGDNUTCWithoutSeconds() -> DateFormatter {
        let dateFormatter        = DateFormatter()
        dateFormatter.locale     = Locale.current
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mmZZZZ"
        
        return dateFormatter
    }
    
    static func dateFormatterForGDNUTCWithSeconds() -> DateFormatter {
        let dateFormatter        = DateFormatter()
        dateFormatter.locale     = Locale.current
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZ"
        
        return dateFormatter
    }
    
    static func dateFromAnyGDNUTCW(dateString: String) -> Date? {
        //parse the start date
        var parsedDateStart = Date.dateFormatterForGDNUTCWithSeconds().date(from: dateString)
        if parsedDateStart == nil {
            parsedDateStart = Date.dateFormatterForGDNUTCWithoutSeconds().date(from: dateString)
        }
        
        return parsedDateStart
    }
    
    static func dateIsPresentInDatesArray(myDate: Date, datesArray: [Date]) -> Bool {
        for date in datesArray {
            let sameDay = Calendar.current.isDate(date, inSameDayAs: myDate)
            if sameDay {
                return true
            }
        }
        return false
    }
    
    /// Returns the amount of minutes from another date
    func minutesFrom(date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute!
    }
}
