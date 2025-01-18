//
//  MainScreen.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-05-06.
//

import SwiftUI


struct MainScreen: View {
    // To add default empty daily schedules if necessary
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var weeklySchedules: FetchedResults<WeeklySchedule>
    
    @StateObject private var viewModel = MainViewModel()
    
    
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor(CustomColours.mediumLightGray)
    }
    
    
    var body: some View {
        NavigationView {
            VStack {
                TabView(selection: $viewModel.selectedIndex) {
                    if let weeklySchedule = viewModel.weeklySchedules.first {
                        WeekOverviewScreen(viewModel: WeekOverviewViewModel(weeklySchedule: weeklySchedule))
                            .tabItem {
                                Label(
                                    "My week",
                                    systemImage: "doc.text.magnifyingglass"
                                )
                            }
                            .tag(0)
                    }

                    if let weeklySchedule = viewModel.weeklySchedules.first {
                        WeeklyBreakdownScreen(viewModel: WeeklyBreakdownViewModel(weeklySchedule: weeklySchedule))
                            .tabItem {
                                Label(
                                    "Day to day",
                                    systemImage: "calendar"
                                )
                            }
                            .tag(1)
                    }

                    TaskListsScreen(viewModel: TaskListsViewModel())
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
        
        // Load default weekly schedules if appropriate
        .onAppear {
            viewModel.assignWeeklySchedules(Array(weeklySchedules), moc: moc)
        }
    }
}


struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
