//
//  TaskListsTabBarItem.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-07-17.
//

import SwiftUI


struct TaskListsTabBarItem: View {
    
    @State var taskType: TaskType
    @Binding var selectedTaskType: TaskType
    
    private var isSelected: Bool {
        return taskType == selectedTaskType
    }
    
    var body: some View {
        Button(
            action: {
                selectedTaskType = taskType
            },
            label: {
                Spacer()
                HStack {
                    Text(taskType.taskListLabelPluralizedShortform)
                        .fixedSize()
                        .foregroundColor(CustomColours.textDarkGray)
                        .font(CustomFonts.taskListsTabBarFont)
                        .lineLimit(1)
                        .padding(2)
                }
                Spacer()
            }
        )
        .frame(height: 36)
        .background(isSelected ? CustomColours.getColourForTaskType(taskType).opacity(0.5) : .white)
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .stroke(
                    CustomColours.getColourForTaskType(taskType),
                    lineWidth: isSelected ? 2 : 0
                )
        )
    }
}
