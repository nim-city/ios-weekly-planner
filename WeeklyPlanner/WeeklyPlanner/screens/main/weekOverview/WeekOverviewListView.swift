//
//  WeekOverviewListView.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-07-17.
//

import Foundation
import SwiftUI

struct WeekItemsListView: View {
    let tasksType: TaskType
    var taskItems: [TaskItem]
    
    @State private var isExpanded = true
    private var listTitle: String {
        switch tasksType {
        case .goal:
            return "Goals"
        case .toDo:
            return "To do items"
        case .toBuy:
            return "To buy items"
        case .meal:
            return "Meals"
        case .workout:
            return "Workouts"
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            // Heading with title label and expand/collapse button
            HStack {
                SubtitleLabel(text: listTitle)
                Button(
                    action: {
                        isExpanded.toggle()
                    },
                    label: {
                        Image(systemName: isExpanded ? "chevron.down.circle" : "chevron.right.circle")
                            .tint(CustomColours.ctaGold)
                    }
                )
                .padding(.leading, 5)
                Spacer()
            }
            .padding(.bottom, 20)
            
            // List of tasks, only shown when in expanded state
            if isExpanded {
                VStack {
                    VStack(spacing: 0) {
                        ForEach(taskItems) { taskItem in
                            WeekOverviewListCell(
                                taskItem: taskItem,
                                shouldShowDivider: taskItem != taskItems.last
                            )
                        }
                    }
                }
                .background(CustomColours.getBackgroundColourForTaskType(tasksType))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(
                            CustomColours.veryLightGray,
                            lineWidth: 5
                        )
                )
            }
        }
    }
}
