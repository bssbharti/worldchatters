//
//  Date+Ex.swift
//  WorldChatters
//
//  Created by Jitendra Kumar on 20/05/19.
//  Copyright © 2019 Jitendra Kumar. All rights reserved.
//

import Foundation


//MARK:- EXTENSION FOR DATE
extension Date {
    
    func displayStyle(dateFormatterStyle style:DateFormatterStyle)->String{
        return style.result(date: self)
    }
    
    var timeDisplay:String{
        get{
            let secondAngle = Int(Date().timeIntervalSince(self))
            let minute = 60
            let hour = 60*minute
            let day  = 24*hour
            let week = 7*day
            let month = 4*week
            let year = 12*month
            let quatient:Int
            let unit:String
            if secondAngle<minute {
                quatient = secondAngle
                unit = "second"
            }else if secondAngle<hour {
                quatient = secondAngle/minute
                unit = "min"
            }else if secondAngle<day {
                quatient = secondAngle/hour
                unit = "hour"
            }else if secondAngle<week {
                quatient = secondAngle/day
                unit = "day"
            }else if secondAngle<month {
                quatient = secondAngle/week
                unit = "week"
            }else  if secondAngle<year {
                quatient = secondAngle/month
                unit = "month"
            }else{
                quatient = secondAngle/year
                unit = "year"
            }
            return "\(quatient) \(unit)\(quatient == 1 ? "" :"s") ago"
        }
    }
    
    
    var age: Int {
        return Calendar.current.dateComponents([.year], from: self, to: Date()).year!
    }
    var next30days:Date{
        let today = Date()
        return Calendar.current.date(byAdding: .day, value: 30, to: today)!
    }
    func isGreaterThanDate(_ dateToCompare: Date) -> Bool {
        return self.compare(dateToCompare) == .orderedDescending ? true : false
    }
    func isGreaterThanEqualDate(_ dateToCompare: Date) -> Bool {
        return (self.compare(dateToCompare) == .orderedDescending || self.compare(dateToCompare) == .orderedSame) ? true : false
    }
    func isEqualDate(_ dateToCompare: Date) -> Bool {
        return self.compare(dateToCompare) == .orderedSame ? true : false
    }
    func isLessThanDate(_ dateToCompare: Date) -> Bool {
        //Return Result
        return self.compare(dateToCompare) == .orderedAscending ? true : false
    }
    func isLessThanEqaulDate(_ dateToCompare: Date) -> Bool {
        //Return Result
        return (self.compare(dateToCompare) == .orderedAscending || self.compare(dateToCompare) == .orderedSame) ? true : false
    }
    func equalToDate(_ dateToCompare: Date) -> Bool {
        //Declare Variables
        var isEqualTo = false
        
        //Compare Values
        if self.compare(dateToCompare) == ComparisonResult.orderedSame {
            isEqualTo = true
        }
        
        //Return Result
        return isEqualTo
    }
    // convert Date to string date
    func dateToString(timeZoneType type:TimeZoneType = .utc,formater:String = "yyyy-MM-dd HH:mm:ss") -> String{
        return DateFormatterType.string(timeZoneType: type, formater: formater).result(date: self) as? String ?? ""
        
    }
    
    func dateToDate(timeZoneType type:TimeZoneType = .utc,formater:String = "yyyy-MM-dd HH:mm:ss") -> Date?{
        return DateFormatterType.date(timeZoneType: type, formater: formater).result(date: self) as? Date
        
    }
    
    func addDays(_ daysToAdd: Int) -> Date {
        let secondsInDays: TimeInterval = Double(daysToAdd * 60 * 60 * 24)
        let dateWithDaysAdded: Date = self.addingTimeInterval(secondsInDays)
        //Return Result
        return dateWithDaysAdded
    }
    
    func addHours(_ hoursToAdd: Int) -> Date {
        let secondsInHours: TimeInterval = Double(hoursToAdd * 60 * 60)
        let dateWithHoursAdded: Date = self.addingTimeInterval(secondsInHours)
        //Return Result
        return dateWithHoursAdded
    }
    
}
enum TimeZoneType:CustomStringConvertible {
    var description: String{
        switch self {
        case .current:
            return "phone_local TimeZone"
        case .utc:
            return "UTC TimeZone"
        case .gmt:
            return "GMT TimeZone"
        default:
            return "Custom TimeZone"
        }
    }
    
    case current
    case utc
    case gmt
    case custom(String)
    var timeZone:TimeZone?{
        switch self {
        case .current:
            return TimeZone.current
        case .utc:
            return TimeZone(abbreviation: "UTC")
        case .gmt:
            return TimeZone(abbreviation: "GMT")
        case .custom(let abbreviation):
            return TimeZone(abbreviation: abbreviation)
            
        }
    }
}

enum TimeZoneDateFormatter {
    case dateFormatter(serverFormat:String,serverTimeZoneType:TimeZoneType,localFormat:String,localTimeZoneType:TimeZoneType)
    func result(dateString:String)->(date:Date?,dateTimeStr:String?){
        if dateString.isEmpty {
            return (nil,nil)
        }
        switch self {
            
        case .dateFormatter(let serverFormat,let serverTimeZoneType , let localFormat,let localTimeZoneType):
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = serverFormat
            dateFormatter.timeZone = serverTimeZoneType.timeZone
            let date = dateFormatter.date(from: dateString)// create date from string
            
            // change to a readable time format and change to local time zone
            dateFormatter.dateFormat = localFormat
            dateFormatter.timeZone = localTimeZoneType.timeZone
            let dateStamp = dateFormatter.string(from: date!)
            return (date,dateStamp)
            
        }
        
        
    }
}
enum DateFormatterType{
    
    case string(timeZoneType :TimeZoneType,formater:String)
    case date(timeZoneType :TimeZoneType,formater:String)
    func result(date:Date)->Any?{
        switch self {
        case .string(let timeZoneType,let formater):
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = formater
            dateFormatter.timeZone = timeZoneType.timeZone
            let dateStamp = dateFormatter.string(from: date)
            return dateStamp
        case .date(let timeZoneType,let formater):
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = formater
            dateFormatter.timeZone = timeZoneType.timeZone
            let dateStamp = dateFormatter.string(from: date)
            let newdate = dateFormatter.date(from: dateStamp)
            return newdate
        }
    }
}
enum DateFormatterStyle {
    case timeDisplay(timeStyle:DateFormatter.Style)
    case dateDisplay(dateStyle:DateFormatter.Style)
    case dateTimeDisplay(timeStyle :DateFormatter.Style,dateStyle:DateFormatter.Style)
    
    static var formatter:DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        return formatter
    }()
    func result(date:Date)->String{
        switch self {
        case .timeDisplay(let timeStyle):
            if timeStyle == .none  {
                return ""
            }
            DateFormatterStyle.formatter.timeStyle = timeStyle
            return DateFormatterStyle.formatter.string(from: date)
        case .dateDisplay(let dateStyle):
            if dateStyle == .none  {
                return ""
            }
            DateFormatterStyle.formatter.dateStyle = dateStyle
            return DateFormatterStyle.formatter.string(from: date)
        case .dateTimeDisplay(let timeStyle, let dateStyle):
            if timeStyle == .none || dateStyle == .none {
                return ""
            }
            DateFormatterStyle.formatter.timeStyle = timeStyle
            DateFormatterStyle.formatter.dateStyle = dateStyle
            return DateFormatterStyle.formatter.string(from: date)
            
        }
        
    }
    
}
