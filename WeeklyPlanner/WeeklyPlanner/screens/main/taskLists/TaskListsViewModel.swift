//
//  TaskListsViewModel.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-09-18.
//

import Foundation
import CoreData


class TaskListsViewModel: ObservableObject {
    
    @Published var selectedTaskType: TaskType = .goal
    @Published var isShowingEditScreen = false
    
    @Published var taskItemViewModel: TaskItemViewModel?
    
    var screenTitle: String {
        switch selectedTaskType {
        case .goal:
            return "Goals"
        case .toDo:
            return "To do items"
        case .toBuy:
            return "To buy items"
        case .meal:
            return "Meals"
        case .workout:
            return "Workout"
        }
    }
}
