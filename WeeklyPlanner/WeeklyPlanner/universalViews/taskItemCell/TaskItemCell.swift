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
                        
                        viewModel.isShowingDeleteAlert = true
                    }
                    viewModel.offset = dragWidth
                }
                .onEnded { dragValue in
                    withAnimation(.snappy(duration: 0.2)) {
                        viewModel.offset = 0
                    }
                }
        )
        
        .alert(
            "Delete \(viewModel.taskItem.name ?? "task item")?",
            isPresented: $viewModel.isShowingDeleteAlert,
            presenting: viewModel.taskItem,
            actions: { taskItem in
                Button(role: .cancel) {
                    viewModel.offset = 0
                    viewModel.isShowingDeleteAlert = false
                } label: {
                    Text("No")
                }
                
                Button(role: .destructive) {
                    viewModel.selectDeleteItem()
                    viewModel.isShowingDeleteAlert = false
                } label: {
                    Text("Yes")
                }
            },
            message: { _ in }
        )
    }
    
    var mainTextView: some View {
        HStack {
            HStack(spacing: 5) {
                Text(viewModel.taskItem.name ?? "Item name")
                    .foregroundColor(CustomColours.textDarkGray)
                    .font(CustomFonts.taskCellFont)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                Button {
                    viewModel.isExpanded.toggle()
                } label: {
                    Image(systemName: viewModel.isExpanded ? "chevron.down.circle" : "chevron.right.circle")
                        .tint(CustomColours.ctaGold)
                }
                Spacer()
            }
            .padding(15)
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
                Text(viewModel.formattedNotes)
                    .font(CustomFonts.taskNotesFont)
                    .lineSpacing(5)
                Spacer()
            }
            .padding(10)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.horizontal, 15)
            .padding(.bottom, 15)
        }
    }
}
