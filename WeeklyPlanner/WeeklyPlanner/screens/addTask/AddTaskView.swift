//
//  AddTaskScreen.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-06-05.
//

import SwiftUI


struct AddTaskView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    
    @ObservedObject var viewModel: TaskItemViewModel
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    content
                        .padding(.horizontal, 20)
                        .padding(.top, 10)
                }
                .frame(maxHeight: .infinity)
                .navigationTitle(viewModel.taskTypeLabel)
                .toolbar {
                    
                    ToolbarItem(placement: .principal) {
                        Rectangle()
                            .frame(width: 60, height: 6)
                            .foregroundStyle(CustomColours.textLightGray)
                            .cornerRadius(3)
                    }
                }
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button {
                            isFocused = false
                        } label: {
                            Text("Done")
                                .font(CustomFonts.buttonFont)
                                .foregroundStyle(CustomColours.ctaGold)
                        }
                    }
                }
            }
        }
    }
    
    private var content: some View {
        VStack(alignment: .leading, spacing: 40) {
            // Task name
            TextInputWithBorder(
                itemName: $viewModel.taskName,
                isFocused: $isFocused,
                colour: CustomColours.getColourForTaskType(viewModel.taskType)
            )
            
            // Task notes
            MultilineTextInputWithBorder(
                text: $viewModel.taskNotes,
                isFocused: $isFocused,
                colour: CustomColours.getColourForTaskType(viewModel.taskType)
            )
            
            // Save and cancel buttons
            buttonsStack
        }
    }
    
    var buttonsStack: some View {
        VStack(spacing: 10) {
            
            // Save button
            PrimaryButton(
                text: "Save",
                backgroundColour: CustomColours.getColourForTaskType(viewModel.taskType)
            ) {
                if viewModel.saveTaskItem(moc: moc) {
                    dismiss()
                }
            }
            
            // Cancel button
            TextButton(text: "Cancel") {
                dismiss()
            }
        }
    }
}

//struct AddItemView_Preview: PreviewProvider {
//    static var previews: some View {
//        AddTaskScreen(viewModel: AddTaskViewModel(taskItemType: .goal))
//    }
//}
