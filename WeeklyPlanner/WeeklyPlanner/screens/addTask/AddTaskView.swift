//
//  AddTaskScreen.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-06-05.
//

import SwiftUI


extension AddTaskScreen {
    
    struct AddTaskView: View {
        
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
}


//struct AddItemView_Preview: PreviewProvider {
//    static var previews: some View {
//        AddTaskScreen(viewModel: AddTaskViewModel(taskItemType: .goal))
//    }
//}
