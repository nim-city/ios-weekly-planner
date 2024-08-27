//
//  TaskListCell.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-07-17.
//

import Foundation
import SwiftUI

// Cell view for any of the task lists in the WeekBreakdownScreen
struct TaskListCell: View {
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var taskItem: TaskItem
    let taskType: TaskType
    var shouldShowDivider = true
    
    @State private var isExpanded = false
    
    var body: some View {
        VStack(spacing: 0) {
            VStack {
                // View shown by default (name and delete button)
                Button(
                    action: {
                        isExpanded.toggle()
                    },
                    label: {
                        HStack {
                            Text(taskItem.name ?? "Item name")
                                .foregroundColor(CustomColours.textDarkGray)
                                .font(CustomFonts.taskCellFont)
                            Spacer()
                            Button(
                                action: {
                                    deleteTaskItem(taskItem)
                                },
                                label: {
                                    Image(systemName: "trash")
                                        .tint(CustomColours.ctaGold)
                                }
                            )
                        }
                    }
                )
                
                // View shown when in expanded mode (notes and edit button)
                if (isExpanded) {
                    VStack(spacing: 20) {
                        HStack {
                            Text(formatNotes())
                                .font(CustomFonts.taskNotesFont)
                            Spacer()
                        }
                        Divider()
                            .background(CustomColours.textDarkGray)
                            .padding(.horizontal, 10)
                        NavigationLink(
                            destination: AddTaskScreen(task: taskItem, itemType: taskType),
                            label: {
                                Text("Edit")
                                    .foregroundColor(CustomColours.ctaGold)
                                    .font(CustomFonts.taskCellFont)
                            }
                        )
                    }
                    .padding(10)
                    .background(CustomColours.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            .padding(15)
            .background(CustomColours.getBackgroundColourForTaskType(taskType).opacity(0.7))
            
            if shouldShowDivider {
                Divider()
                    .padding(.horizontal, 20)
                    .background(CustomColours.getBackgroundColourForTaskType(taskType).opacity(0.7))
            }
        }
    }
    
    // Deletes a TaskItem entirely
    private func deleteTaskItem(_ taskItem: TaskItem) {
        // Delete the task
        moc.delete(taskItem)
        
        // Try to save MOC
        do {
            try moc.save()
        } catch let error {
            print(error)
        }
    }
    
    private func formatNotes() -> String {
        guard let notes = taskItem.notes, !notes.isEmpty else { return "" }
        
        let separatedLines = notes.components(separatedBy: "\n")
        
        return separatedLines.reduce(into: "") { lines, line in
            lines += "• \(line)\n"
        }
    }
}
