//
//  TaskItemCell.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-10-14.
//

import SwiftUI
import AudioToolbox


// Cell view for any of the task lists in the WeekBreakdownScreen
struct TaskItemCell: View {
    @Environment(\.managedObjectContext) var moc
    
    @ObservedObject var viewModel: TaskItemCellViewModel
    
    private let buttonWidth: CGFloat = 150
    private let cellHeight: CGFloat = 50
    
    var body: some View {
        VStack(spacing: 0) {
            // Slide view with edit button, take item name text, and delete button
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    editButton
                    VStack {
                        mainTextView
                            .frame(width: geometry.size.width)
                    }
                    deleteButton
                }
                .offset(x: -buttonWidth)
            }
            .frame(height: cellHeight)
            
            // View shown when in expanded mode (notes and edit button)
            if (viewModel.isExpanded && viewModel.offset == 0) {
                expandedView
            }
        }
        .offset(x: viewModel.offset)
            
        .background(CustomColours.getColourForTaskType(viewModel.taskType).opacity(0.3))
        
        .gesture(
            DragGesture()
                .onChanged { dragValue in
                    var dragWidth = dragValue.translation.width
                    if dragWidth >= buttonWidth {
                        dragWidth = buttonWidth
                        
                        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                        
                        viewModel.selectEditItem()
                        
                        viewModel.offset = 0
                        
                    } else if dragWidth <= -buttonWidth {
                        dragWidth = -buttonWidth
                        
                        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                        
                        viewModel.selectDeleteItem()
                        
                        viewModel.offset = 0
                    }
                    viewModel.offset = dragWidth
                }
                .onEnded { dragValue in
                    withAnimation(.snappy(duration: 0.2)) {
                        viewModel.offset = 0
                    }
                }
        )
    }
    
    var mainTextView: some View {
        HStack {
            HStack(spacing: 15) {
                Text(viewModel.taskItem.name ?? "Item name")
                    .foregroundColor(CustomColours.textDarkGray)
                    .font(CustomFonts.taskCellFont)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                Image(systemName: "chevron.right")
                    .resizable()
                    .frame(width: 5, height: 10)
                    .tint(CustomColours.textDarkGray)
                    .rotationEffect(viewModel.isExpanded ? .degrees(90) : .degrees(0))
                Spacer()
            }
            .padding(15)
            .onTapGesture {
                withAnimation(.easeOut(duration: 0.25)) {
                    viewModel.isExpanded.toggle()
                }
            }
        }
        .frame(height: cellHeight)
    }
    
    var editButton: some View {
        HStack(spacing: 0) {
            Spacer()
            Image(systemName: "square.and.pencil")
                .resizable()
                .tint(CustomColours.ctaGold)
                .padding(12)
                .frame(width: cellHeight)
        }
        .frame(width: buttonWidth)
        .background(.blue)
    }
    
    var deleteButton: some View {
        HStack(spacing: 0) {
            Image(systemName: "trash")
                .resizable()
                .tint(CustomColours.ctaGold)
                .padding(12)
                .frame(width: cellHeight)
            Spacer()
        }
        .frame(width: buttonWidth)
        .background(.red)
    }
    
    var expandedView: some View {
        VStack {
            HStack {
                if viewModel.taskNotes.isEmpty {
                    Text("No notes yet")
                        .font(CustomFonts.taskNotesFont)
                        .italic()
                        .foregroundStyle(CustomColours.textMediumGray)
                } else {
                    Text(viewModel.taskNotes)
                        .font(CustomFonts.taskNotesFont)
                        .lineSpacing(5)
                        .foregroundStyle(CustomColours.textDarkGray)
                }
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 15)
        }
    }
}
