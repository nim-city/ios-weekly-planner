//
//  TaskItemCell.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-10-14.
//

import SwiftUI


// Cell view for any of the task lists in the WeekBreakdownScreen
struct TaskItemCell: View {
    @Environment(\.managedObjectContext) var moc
    
    @ObservedObject var viewModel: TaskItemCellViewModel
    var deleteItem: (TaskItem) -> Void
    var editItem: (TaskItem) -> Void
    
    @State private var isExpanded = false
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 15) {
                // View shown by default (name and delete button)
                Button(
                    action: {
                        isExpanded.toggle()
                    },
                    label: {
                        HStack {
                            Text(viewModel.taskItem.name ?? "Item name")
                                .foregroundColor(CustomColours.textDarkGray)
                                .font(CustomFonts.taskCellFont)
                                .lineLimit(2)
                                .multilineTextAlignment(.leading)
                            Spacer()
                            Button(
                                action: {
                                    deleteItem(viewModel.taskItem)
                                },
                                label: {
                                    Image(systemName: "trash")
                                        .tint(CustomColours.ctaGold)
                                }
                            )
                        }
                        .frame(height: 20)
                    }
                )
                
                // View shown when in expanded mode (notes and edit button)
                if (isExpanded) {
                    VStack(spacing: 15) {
                        HStack {
                            Text(viewModel.formattedNotes)
                                .font(CustomFonts.taskNotesFont)
                                .lineSpacing(5)
                            Spacer()
                        }
                        Divider()
                            .background(CustomColours.textDarkGray)
                            .padding(.horizontal, 10)
                        Button {
                            editItem(viewModel.taskItem)
                        } label: {
                            Text("Edit")
                                .foregroundColor(CustomColours.ctaGold)
                                .font(CustomFonts.taskCellFont)
                        }
                    }
                    .padding(10)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            .padding(15)
        }
    }
}

