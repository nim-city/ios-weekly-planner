//
//  ActionItemType.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-06-13.
//

import Foundation

enum TaskType: Equatable {
    
    case goal
    case toDo
    case toBuy
    case meal
    case workout
    
    func getPluralizedTitle() -> String {
        switch self {
        case .goal:
            return "Goals"
        case .toDo:
            return "To do items"
        case .toBuy:
            return "To buy items"
        case .meal:
            return "Meals"
        case .workout:
            return "Workouts"
        }
    }
}

