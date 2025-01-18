//
//  DateFunctions.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-12-15.
//

import Foundation


class DateFunctions {
    
    private static var adjustedCurrentWeekday: Int {
        let today = Date()
        var currentWeekday = Calendar.current.component(.weekday, from: today)
        
        // Weekday comes back as 1 for Sunday, 2 for Monday... so Move Sunday's value from 1 -> 8 to put it at the end of the week
        if currentWeekday == 1 {
            currentWeekday = 8
        }
        // Shift weekdays down one from 2, 3, ... to 1, 2, ...
        return currentWeekday - 1
    }
    
    private static var weekStartDate: Date? {
        let currentWeekday = adjustedCurrentWeekday - 1
        return Calendar.current.date(byAdding: .day, value: -currentWeekday, to: Date())
    }
    
    private static var weekEndDate: Date? {
        let increment = 7 % adjustedCurrentWeekday
        return Calendar.current.date(byAdding: .day, value: increment, to: Date())
    }
    
    static var startDateString: String {
        guard let weekStartDate else {
            return ""
        }
        
        return getShortDateString(fromDate: weekStartDate)
    }
    
    static var endDateString: String {
        guard let weekEndDate else {
            return ""
        }
        
        return getShortDateString(fromDate: weekEndDate)
    }
    
    private init() {}
    
    private static func getShortDateString(fromDate date: Date) -> String {
        let day = Calendar.current.component(.day, from: date)
        let month = Calendar.current.component(.month, from: date) - 1
        let monthName = Calendar.current.shortMonthSymbols[month]
        
        return "\(monthName) \(day)"
    }
}
