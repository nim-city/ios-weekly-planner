//
//  SelectTaskCell.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-09-15.
//

import SwiftUI

struct SelectTaskCell: View {
    
    var taskItem: TaskItem
    var isSelected: Bool
    var selectTask: (TaskItem) -> Void
    
    var body: some View {
        VStack {
            Button{
                selectTask(taskItem)
            } label: {
                HStack {
                    Text(taskItem.name ?? "No name")
                        .foregroundColor(CustomColours.textDarkGray)
                        .font(CustomFonts.taskCellFont)
                    Spacer()
                    if isSelected {
                        Image(systemName: "checkmark")
                            .tint(CustomColours.ctaGold)
                    }
                }
                .frame(height: 20)
            }
            .padding(15)
        }
        .onTapGesture {
            selectTask(taskItem)
        }
    }
}
