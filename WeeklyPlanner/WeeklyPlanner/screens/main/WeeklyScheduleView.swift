//
//  WeeklyScheduleView.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2025-03-18.
//

import SwiftUI

struct WeeklyScheduleView: View {
    
    @State private var weekSchedule: WeeklySchedule
    @State private var selectedTabIndex = 0
    @State var title: String = "Week Schedule"
    
    init(weekSchedule: WeeklySchedule) {
        
        self.weekSchedule = weekSchedule
        
        UITabBar.appearance().unselectedItemTintColor = UIColor(CustomColours.mediumLightGray)
    }
    
    var body: some View {
        TabView(selection: $selectedTabIndex) {
            WeekOverviewView(viewModel: WeekOverviewViewModel(weeklySchedule: weekSchedule))
                .tabItem {
                    Label(
                        "My week",
                        systemImage: "doc.text.magnifyingglass"
                    )
                }
                .tag(0)

            WeekScheduleView(viewModel: WeekScheduleViewModel(weeklySchedule: weekSchedule))
                .tabItem {
                    Label(
                        "Day to day",
                        systemImage: "calendar"
                    )
                }
                .tag(1)

            TaskListsView(viewModel: TaskListsViewModel())
                .tabItem {
                    Label(
                        "All tasks",
                        systemImage: "list.bullet"
                    )
                }
                .tag(2)
        }
        .tint(CustomColours.ctaGold)
        .navigationTitle(title)
    }
}
