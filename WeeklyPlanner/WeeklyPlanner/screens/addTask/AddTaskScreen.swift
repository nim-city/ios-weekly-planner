//
//  AddItemView.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-06-05.
//

import Foundation
import SwiftUI

private enum InputField: Hashable {
    case name
    case notes
}

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
        ScrollView {
            VStack {
                ScreenTitleLabel(text: screenTitle)
                VStack(spacing: 40) {
                    NameView(
                        itemName: $itemName,
                        isFocused: $isFocused
                    )
                    NotesView(
                        text: $itemNotes,
                        isFocused: $isFocused
                    )
                    VStack(spacing: 20) {
                        Button(
                            action: {
                                if taskToEdit == nil {
                                    addTask()
                                } else {
                                    editTask()
                                }
                            },
                            label: {
                                Text("Save")
                                    .frame(
                                        maxWidth: .infinity,
                                        minHeight: 50,
                                        maxHeight: 50
                                    )
                                    .foregroundColor(CustomColours.accentBlue)
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(
                                                CustomColours.accentBlue,
                                                lineWidth: 3
                                            )
                                    )
                            }
                        )
                        Button(
                            action: {
                                dismiss()
                            },
                            label: {
                                Text("Cancel")
                                    .frame(
                                        maxWidth: .infinity,
                                        minHeight: 50,
                                        maxHeight: 50
                                    )
                                    .foregroundColor(CustomColours.accentBlue)
                                    .font(.title3)
                                    .fontWeight(.bold)
                            }
                        )
                    }
                    .padding(.top, 20)
                }
                .padding(20)
            }
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .top
            )
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Button("Done") {
                        isFocused = false
                    }
                    Spacer()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
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

private struct NameView: View {
    @Binding var itemName: String
    var isFocused: FocusState<Bool>.Binding
    
    var body: some View {
        VStack(alignment: .leading) {
            SubtitleLabel(text: "Name")
            HStack {
                TextField(
                    "Item name",
                    text: $itemName
                )
                .padding(10)
                .focused(isFocused)
            }
            .frame(height: 50)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(
                        CustomColours.accentBlue,
                        lineWidth: 3
                    )
            )
        }
    }
}

private struct NotesView: View {
    @Binding var text: String
    var isFocused: FocusState<Bool>.Binding
    
    var body: some View {
        VStack(alignment: .leading) {
            SubtitleLabel(text: "Notes")
            VStack(spacing: 0) {
                TextEditor(text: $text)
                    .scrollContentBackground(.hidden)
                    .padding(10)
                    .focused(isFocused)
            }
            .background(.white)
            .frame(
                height: 200
            )
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(
                        CustomColours.accentBlue,
                        lineWidth: 3
                    )
            )
        }
    }
}

struct AddItemView_Preview: PreviewProvider {
    static var previews: some View {
        AddTaskScreen(itemType: .goal)
    }
}
