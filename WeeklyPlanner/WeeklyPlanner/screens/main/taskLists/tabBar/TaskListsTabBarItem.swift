//
//  TaskListsTabBarItem.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-07-17.
//

import Foundation
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
                        .font(isSelected ? CustomFonts.selectedFont : CustomFonts.unselectedFont)
                        .lineLimit(1)
                }
                Spacer()
            }
        )
        .padding(.vertical, isSelected ? 10 : 8)
        .padding(.horizontal, isSelected ? 7 : 5)
        .background(CustomColours.getBackgroundColourForTaskType(taskType).opacity(0.5))
        .clipShape(UnevenRoundedRectangle(cornerRadii: .init(topLeading: 10, topTrailing: 10)))
        .overlay {
            UnevenRoundedRectangle(cornerRadii: .init(topLeading: 10, topTrailing: 10))
                .stroke(CustomColours.veryLightGray, lineWidth: 2)
        }
    }
}

