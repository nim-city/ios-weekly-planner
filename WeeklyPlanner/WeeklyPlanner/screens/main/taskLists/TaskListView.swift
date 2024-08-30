//
//  TaskListView.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-07-17.
//

import Foundation
import SwiftUI

struct TaskListView: View {
    let tasksType: TaskType
    var taskItems: [TaskItem]
    
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                ForEach(taskItems) { taskItem in
                    TaskListCell(
                        taskItem: taskItem,
                        taskType: tasksType,
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

