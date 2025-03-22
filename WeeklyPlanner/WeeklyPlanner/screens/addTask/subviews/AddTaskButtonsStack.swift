//
//  AddTaskButtonsStack.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2025-02-16.
//

import SwiftUI

extension AddTaskView {
    
    var buttonsStack: some View {
        VStack(spacing: 10) {
            // Save button
            Button {
                let _ = viewModel.saveTaskItem()
                AddTaskScreen.shared.dismiss()
            } label: {
                Text("Save")
                    .frame(
                        maxWidth: .infinity,
                        minHeight: 50,
                        maxHeight: 50
                    )
                    .foregroundColor(CustomColours.textDarkGray)
                    .background(CustomColours.getColourForTaskType(viewModel.taskItemType))
                    .font(CustomFonts.buttonFont)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .overlay {
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(CustomColours.veryLightGray, lineWidth: 1)
                    }
            }
            
            // Cancel button
            Button {
                AddTaskScreen.shared.dismiss()
            } label: {
                Text("Cancel")
                    .frame(
                        maxWidth: .infinity,
                        minHeight: 50,
                        maxHeight: 50
                    )
                    .foregroundColor(CustomColours.textDarkGray)
                    .font(CustomFonts.buttonFont)
            }
        }
    }
}
