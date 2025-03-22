//
//  WeeklyScheduleViewModel.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2025-03-18.
//

import Foundation
import CoreData

class WeeklyScheduleViewModel: ObservableObject {
    
    @Published var weeklySchedule: WeeklySchedule?
    @Published var selectedTabIndex = 0
    
    private var moc: NSManagedObjectContext
    
    init(weeklySchedule: WeeklySchedule?, moc: NSManagedObjectContext) {
        
        self.weeklySchedule = weeklySchedule
        self.moc = moc
    }
}
