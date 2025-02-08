//
//  TaskItemCell.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-07-17.
//

import Foundation
import SwiftUI

struct TaskItemCell: View {
    @ObservedObject var taskItem: TaskItem
    var shouldShowDivider = true

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(taskItem.name ?? "No name assigned")
                    .foregroundColor(CustomColours.textDarkGray)
                    .font(CustomFonts.taskCellFont)
                    .frame(height: 20)
                Spacer()
            }
            .padding(15)
            if shouldShowDivider {
                Divider()
                    .background(CustomColours.textDarkGray)
                    .padding(.horizontal, 20)
            }
        }
    }
}
