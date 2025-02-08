//
//  WeekOverviewViewModel.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-09-17.
//

import Foundation
import SwiftUI

class WeekOverviewViewModel: ObservableObject {
    
    // Date variables
    var startDateString: String {
        DateFunctions.startDateString
    }
    var endDateString: String {
        DateFunctions.endDateString
    }
    
//    var dateString: NSAttributedString {
//        let font = UIFont.boldSystemFont(ofSize: 15)
//        let startDateString = NSAttributedString(
//            string: DateFunctions.startDateString,
//            attributes: [.font: Font.callout.bold()]
//        )
//        let endDateString = NSAttributedString(
//            string: DateFunctions.endDateString,
//            attributes: [.font: Font.callout.bold()]
//        )
//        let attributedString = NSMutableAttributedString(string: "Current week: \(startDateString) to \(endDateString).")
//        attributedString.addAttribute(.font, value: <#T##Any#>, range: <#T##NSRange#>)
//        
//    }
    var dateString: String {
        "\(startDateString) - \(endDateString)"
    }
    
    
    @Published var weeklySchedule: WeeklySchedule

    @Published var isShowingSelectScreen = false
    @Published var notes = ""
    private let notesDataController = WeeklyNotesDataController()
    
    init(weeklySchedule: WeeklySchedule) {
        self.weeklySchedule = weeklySchedule
        self.notes = self.notesDataController.getWeeklyNotes()
    }
    
    
    func saveNotes() {
        self.notesDataController.setWeeklyNotes(newNotes: notes)
    }
}
