//
//  AddTaskScreen.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-06-05.
//

import SwiftUI


struct AddTaskScreen: View {
    @Environment(\.managedObjectContext) var moc
    // To allow for manual dismiss
    @Environment(\.dismiss) var dismiss
    
    @FocusState private var isFocused: Bool
    @ObservedObject var viewModel: TaskItemViewModel
    
    
    var body: some View {
        NavigationSplitView {
            ScrollView {
                VStack {
                    VStack(spacing: 40) {
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
                            .padding(.top, 40)
                    }
                    .padding(20)
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
            .toolbar {
                ToolbarItem(placement: .principal) {
                    ScreenTitleLabel(text: viewModel.itemTypeLabel)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationBarBackButtonHidden(true)
        } detail: {
            Text("Add task screen")
        }
    }
}


// MARK: Bottom buttons


extension AddTaskScreen {
    var buttonsStack: some View {
        VStack(spacing: 10) {
            // Save button
            Button {
                let _ = viewModel.saveTaskItem(moc: moc)
                dismiss()
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


struct AddItemView_Preview: PreviewProvider {
    static var previews: some View {
        AddTaskScreen(viewModel: AddTaskViewModel(taskItemType: .goal))
    }
}
