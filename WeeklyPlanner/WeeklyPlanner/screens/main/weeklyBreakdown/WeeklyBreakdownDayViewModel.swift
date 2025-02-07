//
//  WeeklyBreakdownDayViewModel.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2025-02-02.
//

import Foundation
import CoreData

class WeeklyBreakdownDayViewModel: ObservableObject {
    
    @Published var isShowingSelectScreen = false
    @Published var isShowingDeleteAlert = false
    
    @Published var dailySchedule: DailySchedule
    
    let taskTypes: [TaskType] = [.toDo, .toBuy, .meal, .workout]
    
    var selectedTaskItem: TaskItem?
    var selectedTasksType: TaskType?
    
    init(dailySchedule: DailySchedule) {
        self.dailySchedule = dailySchedule
    }
    
    func selectItemToEdit(taskItem: TaskItem) {
        selectedTaskItem = taskItem
        isShowingSelectScreen = true
    }
    
    func selectItemToDelete(taskItem: TaskItem) {
        selectedTaskItem = taskItem
        isShowingDeleteAlert = true
    }
    
    func selectMoreItems(ofType tasksType: TaskType) {
        selectedTasksType = tasksType
        isShowingSelectScreen = true
    }
    
    func removeSelectedItem(moc: NSManagedObjectContext) -> Bool {
        guard let item = selectedTaskItem else {
            return false
        }
        
        if !dailySchedule.removeTaskItemFromList(item) {
            return false
        }
        
        return saveMOC(moc)
    }
    
    func deleteSelectedItem(moc: NSManagedObjectContext) -> Bool {
        guard let item = selectedTaskItem else {
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
