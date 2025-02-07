//
//  WeekOverviewListView.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-07-17.
//

import Foundation
import SwiftUI

struct WeekItemsListView<TrailingView: View>: View {
    
    let tasksType: TaskType
    var taskItems: [TaskItem]
    let trailingView: () -> TrailingView
    
    var title: String {
        tasksType.getPluralizedTitle()
    }
    
    init(
        tasksType: TaskType,
        taskItems: [TaskItem],
        @ViewBuilder trailingView: @escaping () -> TrailingView = { EmptyView() }
    ) {
        self.tasksType = tasksType
        self.taskItems = taskItems
        self.trailingView = trailingView
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
        } trailingView: {
            trailingView()
        }
    }
}
