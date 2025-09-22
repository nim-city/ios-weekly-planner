//
//  AddWeekScheduleViewModel.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2025-07-09.
//

import Foundation
import CoreData

class AddWeekScheduleViewModel: ObservableObject {
    
    @Published var weekSchedule: WeeklySchedule?
    @Published var weekScheduleName: String
    
    init(weekSchedule: WeeklySchedule? = nil) {
        
        self.weekSchedule = weekSchedule
        self.weekScheduleName = weekSchedule?.name ?? ""
    }
    
    func save(moc: NSManagedObjectContext) -> Bool {
        
        if let weekSchedule {
            
            weekSchedule.name = weekScheduleName
        } else {
            
            let newWeekSchedule = WeeklySchedule(context: moc)
            newWeekSchedule.name = weekScheduleName
        }
        
        do {
            
            try moc.save()
            return true
        } catch let error {
            
            print(error)
            return false
        }
    }
}
