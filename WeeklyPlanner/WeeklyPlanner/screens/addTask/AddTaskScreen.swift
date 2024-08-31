//
//  AddItemView.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-06-05.
//

import SwiftUI


struct AddTaskScreen: View {
    @Environment(\.managedObjectContext) var moc
    
    // To allow for manual dismiss
    @Environment(\.dismiss) var dismiss
    
    @State var itemType: TaskType
    var taskToEdit: TaskItem?
    
    @State var itemName: String
    @State var itemNotes: String
    var screenTitle: String {
        let itemTypeName: String
        switch itemType {
        case .goal:
            itemTypeName = "goal"
        case .toDo:
            itemTypeName =  "to do item"
        case .toBuy:
            itemTypeName =  "to buy item"
        case .meal:
            itemTypeName =  "meal"
        case .workout:
            itemTypeName =  "workout"
        }
        if taskToEdit == nil {
            return "New \(itemTypeName)"
        } else {
            return "Edit \(itemTypeName)"
        }
    }
    @FocusState private var isFocused: Bool
    
    init(itemType: TaskType) {
        self._itemType = State(initialValue: itemType)
        self._itemName = State(initialValue: "")
        self._itemNotes = State(initialValue: "")
    }
    
    init(task: TaskItem, itemType: TaskType) {
        self.taskToEdit = task
        self._itemType = State(initialValue: itemType)
        
        self._itemName = State(initialValue: task.name ?? "")
        self._itemNotes = State(initialValue: task.notes ?? "")
    }
    
    var body: some View {
        NavigationSplitView {
            ScrollView {
                VStack {
                    VStack(spacing: 40) {
                        // Task name
                        AddTaskNameInput(
                            itemName: $itemName,
                            isFocused: $isFocused,
                            colour: CustomColours.getColourForTaskType(itemType)
                        )
                        
                        // Task notes
                        AddTaskNotesView(
                            text: $itemNotes,
                            isFocused: $isFocused,
                            colour: CustomColours.getColourForTaskType(itemType)
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
                    ScreenTitleLabel(text: screenTitle)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationBarBackButtonHidden(true)
        } detail: {
            Text("Add task screen")
        }
    }
    
    private func addTask() {
        switch itemType {
        case .goal:
            let item = Goal(context: moc)
            item.name = itemName
            item.notes = itemNotes
        case .toDo:
            let item = ToDoItem(context: moc)
            item.name = itemName
            item.notes = itemNotes
            item.categoryName = ToDoItemCategory.shortTerm.rawValue
        case .toBuy:
            let item = ToBuyItem(context: moc)
            item.name = itemName
            item.notes = itemNotes
        case .meal:
            let item = Meal(context: moc)
            item.name = itemName
            item.notes = itemNotes
        case .workout:
            let item = Workout(context: moc)
            item.name = itemName
            item.notes = itemNotes
        }
        do {
            try moc.save()
            dismiss()
        } catch let error {
            print(error)
        }
    }
    
    private func editTask() {
        taskToEdit?.name = itemName
        taskToEdit?.notes = itemNotes
        do {
            try moc.save()
            dismiss()
        } catch let error {
            print(error)
        }
    }
}


// MARK: Bottom buttons


extension AddTaskScreen {
    var buttonsStack: some View {
        VStack(spacing: 10) {
            // Save button
            Button {
                if taskToEdit == nil {
                    addTask()
                } else {
                    editTask()
                }
            } label: {
                Text("Save")
                    .frame(
                        maxWidth: .infinity,
                        minHeight: 50,
                        maxHeight: 50
                    )
                    .foregroundColor(CustomColours.textDarkGray)
                    .background(CustomColours.getColourForTaskType(itemType))
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
        AddTaskScreen(itemType: .goal)
    }
}
