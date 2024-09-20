//
//  WeeklyNotesDataController.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-09-19.
//

import Foundation


class WeeklyNotesDataController: ObservableObject {
    private let weeklyNotesKey = "weekly_notes"
    
    
    func setWeeklyNotes(newNotes: String) {
        UserDefaults.standard.setValue(newNotes, forKey: weeklyNotesKey)
    }
    
    
    func getWeeklyNotes() -> String {
        UserDefaults.standard.string(forKey: weeklyNotesKey) ?? ""
    }
}
