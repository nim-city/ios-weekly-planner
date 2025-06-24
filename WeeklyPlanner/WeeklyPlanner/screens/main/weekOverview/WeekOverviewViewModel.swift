//
//  WeekOverviewViewModel.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-09-17.
//

import Foundation
import SwiftUI
import CoreData

class WeekOverviewViewModel: ObservableObject {
    
    @Published var weeklySchedule: WeeklySchedule

    @Published var isShowingSelectScreen = false
    @Published var isShowingClearItemsAlert = false
    @Published var notes = ""
    
    @Published var selectedGoalToEdit: TaskItem?
    @Published var selectedGoalToDelete: Goal?
    
    // Date variables
    var startDateString: String {
        DateFunctions.startDateString
    }
    var endDateString: String {
        DateFunctions.endDateString
    }
    var dateString: String {
        "\(startDateString) - \(endDateString)"
    }
    
    init(weeklySchedule: WeeklySchedule) {
        self.weeklySchedule = weeklySchedule
        if let notes = weeklySchedule.notes {
            self.notes = notes
        }
    }
    
    func removeSelectedItem(moc: NSManagedObjectContext) -> Bool {
        guard let selectedGoalToDelete else {
            return false
        }
        
        weeklySchedule.removeFromGoals(selectedGoalToDelete)
        
        return saveMOC(moc)
    }
    
    func deleteSelectedItem(moc: NSManagedObjectContext) -> Bool {
        guard let selectedGoalToDelete else {
            return false
        }
        
        moc.delete(selectedGoalToDelete)
        
        return saveMOC(moc)
    }
    
    @discardableResult
    func resetGoals(moc: NSManagedObjectContext) -> Bool {
        
        var wasResetSuccessful = weeklySchedule.removeAllGoals()
        
        if wasResetSuccessful {
            wasResetSuccessful = saveMOC(moc)
        }
        
        return wasResetSuccessful
    }
    
    @discardableResult
    func resetDailySchedules(moc: NSManagedObjectContext) -> Bool {
        
        var wasResetSuccessful = weeklySchedule.resetDailySchedules()
        
        if wasResetSuccessful {
            wasResetSuccessful = saveMOC(moc)
        }
        
        return wasResetSuccessful
    }
    
    // TODO: Add reset week functionality
    
    private func saveMOC(_ moc: NSManagedObjectContext) -> Bool {
        do {
            try moc.save()
            return true
        } catch let error {
            print(error)
            return false
        }
    }
    
    func saveNotes(moc: NSManagedObjectContext) -> Bool {
        weeklySchedule.notes = self.notes
        return saveMOC(moc)
    }
}
