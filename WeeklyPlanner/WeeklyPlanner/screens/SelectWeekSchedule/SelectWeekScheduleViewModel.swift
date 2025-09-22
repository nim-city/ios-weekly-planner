//
//  SelectWeekScheduleViewModel.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2025-07-04.
//

import Foundation

class SelectWeekScheduleViewModel: ObservableObject {
    
    @Published var weekSchedules: [WeeklySchedule] = []
    @Published var selectedWeekSchedule: WeeklySchedule?
    
    @Published var isPresentingAddScheduleSheet = false
    @Published var isPresentingSaveFailedAlert = false
    @Published var isPresentingDeleteAlert = false
    
    func setUpViews(weekSchedules: [WeeklySchedule]) {
        
        self.weekSchedules = weekSchedules
        
        setCurrentSchedule()
    }
    
    private func setCurrentSchedule() {
        // TODO: Fetch and assign currently selected week schedule
    }
    
}
