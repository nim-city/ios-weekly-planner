//
//  AddWeekScheduleView.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2025-07-09.
//

import SwiftUI

struct AddWeekScheduleSheetView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var viewModel: AddWeekScheduleViewModel
    
    var body: some View {
        VStack {
            Text("Add Week Schedule")
            
            // No need to localize this string
            TextField("Week schedule text field", text: $viewModel.weekScheduleName)
            
            PrimaryButton(text: "Save", backgroundColour: CustomColours.ctaGold) {
                
                let wasSaveSuccessful = viewModel.save(moc: moc)
                if wasSaveSuccessful {
                    
                    dismiss()
                } else {
                    
                    // TODO: Show some sort of error message
                }
            }
        }
    }
}
