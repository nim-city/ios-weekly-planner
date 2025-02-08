//
//  TaskItemList.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2025-02-06.
//

import SwiftUI

struct TaskItemList: View {
    
    let tasksType: TaskType
    var taskItems: [TaskItem]
    
    var title: String {
        tasksType.getPluralizedTitle()
    }
    
    init(
        tasksType: TaskType,
        taskItems: [TaskItem]
    ) {
        self.tasksType = tasksType
        self.taskItems = taskItems
    }
    

    var body: some View {
        CollapsibleView(title: title) {
            
            VStack {
                VStack(spacing: 0) {
                    ForEach(taskItems) { taskItem in
                        
                        TaskItemCell(
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

