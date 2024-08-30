//
//  TaskListsTabBarItem.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-07-17.
//

import SwiftUI


struct TaskListsTabBarItem: View {
    let taskType: TaskType
    @Binding var selectedTaskType: TaskType
    
    var title: String {
        switch taskType {
        case .goal:
            return "Goals"
        case .toDo:
            return "To do"
        case .toBuy:
            return "To buy"
        case .meal:
            return "Meals"
        case .workout:
            return "Workout"
        }
    }
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
                    Text(title)
                        .fixedSize()
                        .foregroundColor(CustomColours.textDarkGray)
                        .font(CustomFonts.tabBarFont)
                        .lineLimit(1)
                        .padding(2)
                }
                Spacer()
            }
        )
        .frame(height: 36)
        .background(isSelected ? CustomColours.getBackgroundColourForTaskType(taskType).opacity(0.5) : .white)
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
}
