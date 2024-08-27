//
//  DayOfTheWeek.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2023-12-27.
//

import Foundation

enum DayOfTheWeek: String, CaseIterable {
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case sunday
    
    var capitalizedName: String {
        return self.rawValue.capitalized
    }
    
    static func ordered() -> [DayOfTheWeek] {
        return [
            .monday,
            .tuesday,
            .wednesday,
            .thursday,
            .friday,
            .saturday,
            .sunday
        ]
    }
    
    static func getDayFromIndex(_ index: Int) -> DayOfTheWeek? {
        guard index >= 0 && index < 7 else { return nil }
        return ordered()[index]
    }
}
