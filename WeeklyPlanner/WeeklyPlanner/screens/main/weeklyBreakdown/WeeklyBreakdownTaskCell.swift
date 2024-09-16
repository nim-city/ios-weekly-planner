//
//  WeeklyBreakdownTaskCell.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-08-26.
//

import SwiftUI

struct WeeklyBreakdownTaskCell: View {
    var taskItem: TaskItem
    let taskType: TaskType
    let removeTaskItem: (TaskItem) -> Void
    
    @State private var isExpanded = false
    
    var body: some View {
        VStack {
            VStack {
                // View shown by default (name and delete button)
                Button(
                    action: {
                        isExpanded.toggle()
                    },
                    label: {
                        HStack {
                            Text(taskItem.name ?? "Item name")
                                .font(CustomFonts.taskCellFont)
                                .foregroundStyle(CustomColours.textDarkGray)
                            Spacer()
                            Button(
                                action: {
                                    removeTaskItem(taskItem)
                                },
                                label: {
                                    Image(systemName: "trash")
                                        .tint(CustomColours.ctaGold)
                                }
                            )
                        }
                        .frame(height: 20)
                    }
                )
                
                // View shown when in expanded mode (notes and edit button)
                if (isExpanded) {
                    VStack(spacing: 20) {
                        Divider()
                            .background(CustomColours.textDarkGray)
                            .padding(.top, 8)
                        HStack {
                            Text(taskItem.notes ?? "No notes")
                            Spacer()
                        }
                        NavigationLink(
                            destination: AddTaskScreen(task: taskItem, itemType: taskType),
                            label: {
                                Text("Edit")
                                    .foregroundColor(CustomColours.ctaGold)
                            }
                        )
                    }
                }
            }
            .padding(15)
        }
    }
}
