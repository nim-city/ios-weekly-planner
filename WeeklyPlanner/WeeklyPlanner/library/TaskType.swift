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
    
    var taskListLabel: String {
        switch self {
        case .goal:
            return "Goal"
        case .toDo:
            return "To do item"
        case .toBuy:
            return "To buy item"
        case .meal:
            return "Meal"
        case .workout:
            return "Workout"
        }
    }
    
    var taskListLabelPluralized: String {
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
    
    var taskListLabelPluralizedShortform: String {
        switch self {
        case .goal:
            return "Goals"
        case .toDo:
            return "To do"
        case .toBuy:
            return "To buy"
        case .meal:
            return "Meals"
        case .workout:
            return "Workouts"
        }
    }
}

