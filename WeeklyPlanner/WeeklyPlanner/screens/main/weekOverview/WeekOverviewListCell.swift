//
//  WeekOverviewCell.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-07-17.
//

import Foundation
import SwiftUI

struct WeekOverviewListCell: View {
    @ObservedObject var taskItem: TaskItem
    var shouldShowDivider = true

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(taskItem.name ?? "No name assigned")
                    .foregroundColor(CustomColours.textDarkGray)
                    .font(CustomFonts.taskCellFont)
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
