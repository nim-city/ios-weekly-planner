//
//  DayScheduleViewModel.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2025-02-02.
//

import Foundation
import CoreData

class DayScheduleViewModel: ObservableObject {

    @Published var dailySchedule: DailySchedule
    
    @Published var taskItemToEdit: TaskItem?
    @Published var taskItemToDelete: TaskItem?
    
    var selectedTasksType: TaskType?
    @Published var isPresentingSelectTasksView: Bool = false
    
    let taskTypes: [TaskType] = [.toDo, .toBuy, .meal, .workout]
    
    init(dailySchedule: DailySchedule) {
        self.dailySchedule = dailySchedule
    }

    @discardableResult
    func removeSelectedItem(moc: NSManagedObjectContext) -> Bool {
        guard let item = taskItemToDelete else {
            return false
        }
        
        if !dailySchedule.removeTaskItemFromList(item) {
            return false
        }
        
        return saveMOC(moc)
    }
    
    @discardableResult
    func deleteSelectedItem(moc: NSManagedObjectContext) -> Bool {
        guard let item = taskItemToDelete else {
            return false
        }
        
        moc.delete(item)
        
        return saveMOC(moc)
    }
    
    private func saveMOC(_ moc: NSManagedObjectContext) -> Bool {
        do {
            try moc.save()
            return true
        } catch let error {
            print(error)
            return false
        }
    }
}
