//
//  ListScreenTabBar.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-05-24.
//

import Foundation
import SwiftUI

struct TaskListsTabBar: View {
    @Binding var selectedTaskType: TaskType

    var body: some View {
        HStack(alignment: .bottom, spacing: 2) {
            TaskListsTabBarItem(
                taskType: .goal,
                selectedTaskType: $selectedTaskType
            )
            TaskListsTabBarItem(
                taskType: .toDo,
                selectedTaskType: $selectedTaskType
            )
            TaskListsTabBarItem(
                taskType: .toBuy,
                selectedTaskType: $selectedTaskType
            )
            TaskListsTabBarItem(
                taskType: .meal,
                selectedTaskType: $selectedTaskType
            )
            TaskListsTabBarItem(
                taskType: .workout,
                selectedTaskType: $selectedTaskType
            )
        }
        .frame(
            alignment: .center
        )
    }
}


struct TaskListTabBar_Previews: PreviewProvider {
    
    @State static var selectedTaskType: TaskType = .goal
    
    static var previews: some View {
        TaskListsTabBar(selectedTaskType: $selectedTaskType)
    }
}
