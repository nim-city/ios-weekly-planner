//
//  WeeklyBreakdownDayViewModel.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-12-04.
//

import Foundation


class WeeklyBreakdownDayViewModel: ObservableObject {
    
    var selectedTaskType: TaskType?
    
    @Published var isPresentingAddTaskAlert: Bool = false
    
    init() {}
    
    
    func selectTaskType(_ taskType: TaskType) {
        selectedTaskType = taskType
        
        isPresentingAddTaskAlert = true
    }
}
