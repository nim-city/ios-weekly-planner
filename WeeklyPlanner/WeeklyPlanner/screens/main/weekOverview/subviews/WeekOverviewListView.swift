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
        CollapsibleView(title: listTitle) {
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
            .background(CustomColours.getColourForTaskType(tasksType).opacity(0.3))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(
                        CustomColours.getColourForTaskType(tasksType),
                        lineWidth: 4
                    )
            )
        }
    }
}
