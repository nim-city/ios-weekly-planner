//
//  WeeklyScheduleView.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2025-03-18.
//

import SwiftUI

struct WeeklyScheduleView: View {
    
    @ObservedObject private var viewModel: WeeklyScheduleViewModel
    
    init(viewModel: WeeklyScheduleViewModel) {
        
        self.viewModel = viewModel
        
        UITabBar.appearance().unselectedItemTintColor = UIColor(CustomColours.mediumLightGray)
    }
    
    var body: some View {
        VStack {
            TabView(selection: $viewModel.selectedTabIndex) {
                if let weeklySchedule = viewModel.weeklySchedule {
                    WeekOverviewScreen(viewModel: WeekOverviewViewModel(weeklySchedule: weeklySchedule))
                        .tabItem {
                            Label(
                                "My week",
                                systemImage: "doc.text.magnifyingglass"
                            )
                        }
                        .tag(0)
                }

                if let weeklySchedule = viewModel.weeklySchedule {
                    WeeklyBreakdownScreen(viewModel: WeeklyBreakdownViewModel(weeklySchedule: weeklySchedule))
                        .tabItem {
                            Label(
                                "Day to day",
                                systemImage: "calendar"
                            )
                        }
                        .tag(1)
                }

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
        }
    }
}
