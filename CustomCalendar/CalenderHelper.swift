//
//  CalenderHelper.swift
//  CustomCalendar
//
//  Created by apple on 13/03/21.
//

import Foundation
import UIKit

class CalendarHelper {
    
    let calendar = Calendar.current
    
    //Increment of Month
    func plusMonth(date: Date) -> Date {
        return calendar.date(byAdding: .month, value: 1, to: date)!
    }
    
    //Decrement of Month
    func minusMonth(date: Date) -> Date {
        return calendar.date(byAdding: .month, value: -1, to: date)!
    }
    
    //Getting Current Month
    func monthString(date: Date) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        return dateFormatter.string(from: date)
    }
    
    //Getting Current year
    func yearString(date: Date) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: date)
    }
    
    //Getting Days in month (overall days 31,30,28 etc)
    func dayInMonth(date: Date) -> Int {
        let range = calendar.range(of: .day, in: .month, for: date)!
        return range.count
    }
    
    //Getting Days in month (eg:- 3Jan,2020 -> 3)
    func dayOfMonth(date: Date) -> Int {
        let component = calendar.dateComponents([.day], from: date)
        return component.day!
    }
    
    //Getting initial date of the Month by giving any date in the month (eg:- 15 jan 2020 -> 1jan2020)
    func firstOfMonth(date: Date) -> Date {
        let component = calendar.dateComponents([.year, .month], from: date)
        return calendar.date(from: component)!
    }
    
    //Getting day of the Month
    func weekDay(date: Date) -> Int {
        
        let component = calendar.dateComponents([.weekday], from: date)
        return component.weekday! - 1
    }
    
}
