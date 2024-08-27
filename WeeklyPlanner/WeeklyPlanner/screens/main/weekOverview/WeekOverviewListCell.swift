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
                    .fontWeight(.medium)
                Spacer()
            }
            .padding(20)
            if shouldShowDivider {
                Divider()
                    .background(CustomColours.textDarkGray)
                    .padding(.horizontal, 20)
            }
        }
    }
}
