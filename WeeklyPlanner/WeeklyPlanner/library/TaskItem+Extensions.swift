//
//  TaskItem+Extensions.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2025-02-01.
//

import Foundation

extension TaskItem {
    
    var taskType: TaskType? {
        if self as? Goal != nil {
            return .goal
        } else if self as? ToDoItem != nil {
            return .toDo
        } else if self as? ToBuyItem != nil {
            return .toBuy
        } else if self as? Workout != nil {
            return .workout
        } else if self as? Meal != nil {
            return .meal
        } else {
            return nil
        }
    }
}
