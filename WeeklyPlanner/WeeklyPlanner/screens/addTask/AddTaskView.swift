//
//  AddTaskScreen.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-06-05.
//

import SwiftUI


struct AddTaskView: View {
    
    @Environment(\.dismiss) var dismiss
    @FocusState private var isFocused: Bool
    @ObservedObject var viewModel: TaskItemViewModel
    
    
    var body: some View {
        ZStack(alignment: .center) {
            
            // Blur view
            BlurredBackgroundView()
                .edgesIgnoringSafeArea(.all)
            
            // Main content
            VStack {
                VStack(alignment: .leading, spacing: 40) {
                    // Title
                    LargeTitleLabel(text: viewModel.itemTypeLabel)
                    
                    // Task name
                    AddTaskNameInput(
                        itemName: $viewModel.taskName,
                        isFocused: $isFocused,
                        colour: CustomColours.getColourForTaskType(viewModel.taskItemType)
                    )
                    
                    // Task notes
                    AddTaskNotesView(
                        text: $viewModel.taskNotes,
                        isFocused: $isFocused,
                        colour: CustomColours.getColourForTaskType(viewModel.taskItemType)
                    )
                    
                    // Save and cancel buttons
                    buttonsStack
                }
                .padding(20)
            }
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(CustomColours.getColourForTaskType(viewModel.taskItemType), lineWidth: 4)
            )
            .padding(.horizontal, 40)
            .padding(.vertical, 120)
        }
    }
}

extension AddTaskView {
    
    var buttonsStack: some View {
        VStack(spacing: 10) {
            // Save button
            Button {
                if viewModel.saveTaskItem() {
                    dismiss()
                }
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
                dismiss()
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

//struct AddItemView_Preview: PreviewProvider {
//    static var previews: some View {
//        AddTaskScreen(viewModel: AddTaskViewModel(taskItemType: .goal))
//    }
//}
