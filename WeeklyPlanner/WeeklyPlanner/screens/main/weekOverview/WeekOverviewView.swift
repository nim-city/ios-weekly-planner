//
//  WeekOverviewView.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-05-06.
//

import Foundation
import SwiftUI

struct WeekOverviewView: View {
    
    @Environment(\.managedObjectContext) var moc
    
    @StateObject var viewModel: WeekOverviewViewModel
    
    @FocusState var isFocused
    @State var uuid = UUID()
        
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 40) {
                    subheading
                    
                    mainContent
                }
                .padding(20)
                .id(uuid)
            }
            // Sizing and positioning
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .leading
            )
            // Navigation toolbar
            .navigationTitle("Week overview")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.isShowingClearItemsAlert = true
                    } label: {
                        Image(systemName: "eraser.line.dashed")
                            .tint(CustomColours.ctaGold)
                    }
                }
            }
            
            // Keyboard done button for saving notes
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button {
                        isFocused = false
                        let _ = viewModel.saveNotes(moc: moc)
                    } label: {
                        Text("Done")
                            .font(CustomFonts.buttonFont)
                            .foregroundStyle(CustomColours.ctaGold)
                    }
                }
            }

            // Edit task item sheet
            .editTaskItemSheet(taskItemToEdit: $viewModel.selectedGoalToEdit, taskType: .goal)
            
            // Delete alert
            .removeOrDeleteItemsAlert(
                isShowingAlert: Binding(
                    get: { return viewModel.selectedGoalToDelete != nil },
                    set: { if !$0 { viewModel.selectedGoalToDelete = nil } }
                ),
                removeItemAction: {
                    _ = viewModel.removeSelectedItem(moc: moc)
                },
                deleteItemAction: {
                    _ = viewModel.deleteSelectedItem(moc: moc)
                })
            
            // Clear all items alert
            .alert("Reset this week?", isPresented: $viewModel.isShowingClearItemsAlert) {
                
                Button("Neither", role: .cancel) { }
                
                Button("All items", role: .destructive) {
                    viewModel.resetDailySchedules(moc: moc)
                }
                
                Button("Goals", role: .destructive) {
                    viewModel.resetGoals(moc: moc)
                }
            } message: {
                Text("Do you want to remove all items for this week or just this week's goals?")
            }
            
            .navigationDestination(isPresented: $viewModel.isShowingSelectScreen) {
                SelectTasksView(viewModel: SelectTasksViewModel(
                    taskType: .goal,
                    weeklySchedule: viewModel.weeklySchedule
                ))
            }
            .onAppear {
                refreshView()
            }
        }
    }
    
    private var subheading: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(viewModel.dateString)
                .bold()
            SubheadingLabel(text: "All of my goals, to do items, meals, and workouts for the week.")
        }
    }
    
    private var mainContent: some View {
        VStack(spacing: 40) {

            // Goals
            EditableTaskItemList(
                taskItems: viewModel.weeklySchedule.allGoals,
                tasksType: .goal,
                editTaskItem: { taskItem in
                    
                    viewModel.selectedGoalToEdit = taskItem as? Goal
                },
                deleteTaskItem: { taskItem in
                    
                    viewModel.selectedGoalToDelete = taskItem as? Goal
                },
                selectTaskItems: { taskItem in
                    
                    viewModel.isShowingSelectScreen = true
                }
            )
            
            // To do item
            TaskItemList(
                tasksType: .toDo,
                taskItems: viewModel.weeklySchedule.allToDoItems
            )
            
            // To buy items
            TaskItemList(tasksType: .toBuy,
                         taskItems: viewModel.weeklySchedule.allToBuyItems)
            
            // Workouts
            TaskItemList(
                tasksType: .workout,
                taskItems: viewModel.weeklySchedule.allWorkouts
            )
            
            // Notes
            NotesView(
                text: $viewModel.notes,
                isFocused: $isFocused
            )
        }
    }
    
    private func refreshView() {
        uuid = UUID()
    }
}

//struct WeekOverviewScreen_Preview: PreviewProvider {
//    static var previews: some View {
//        // Add mock items to CoreData
//        let moc = CoreDataController().moc
//        let _ = MockListItems(moc: moc)
//
//        return WeekOverviewScreen()
////            .environment(\.managedObjectContext, moc)
//    }
//}
