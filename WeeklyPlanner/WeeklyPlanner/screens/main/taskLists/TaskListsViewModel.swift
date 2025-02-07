//
//  TaskListsViewModel.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-09-18.
//

import Foundation


class TaskListsViewModel: ObservableObject {
    
    // Model related
    @Published var selectedTaskType: TaskType = .goal
    
    // UI related
    @Published var isShowingAddScreen = false
    
    // Computed
    var screenTitle: String {
        return selectedTaskType.getPluralizedTitle()
    }
}
