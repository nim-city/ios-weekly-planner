//
//  AddTaskItemSheet.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2025-04-07.
//

import SwiftUI

struct AddTaskItemSheet: ViewModifier {
    
    @Binding var isShowing: Bool
    let taskType: TaskType
    let daySchedule: DailySchedule?
    let weekSchedule: WeeklySchedule?
    
    func body(content: Content) -> some View {
        content
            .sheet(isPresented: $isShowing) {
                AddTaskView(viewModel: AddTaskViewModel(
                    taskType: taskType,
                    daySchedule: daySchedule,
                    weekSchedule: weekSchedule
                ))
                .presentationDetents([.fraction(0.8)])
                .presentationCornerRadius(16)
            }
    }
}

extension View {
    
    func addTaskItemSheet(
        isShowing: Binding<Bool>,
        taskType: TaskType,
        daySchedule: DailySchedule? = nil,
        weekSchedule: WeeklySchedule? = nil
    ) -> some View {
        
        modifier(AddTaskItemSheet(
            isShowing: isShowing,
            taskType: taskType,
            daySchedule: daySchedule,
            weekSchedule: weekSchedule
        ))
    }
}
