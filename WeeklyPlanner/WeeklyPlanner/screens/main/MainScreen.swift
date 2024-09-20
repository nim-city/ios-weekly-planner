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
    @FetchRequest(sortDescriptors: []) var dailySchedules: FetchedResults<DailySchedule>
    
    @StateObject private var viewModel = MainViewModel()
    
    
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor(CustomColours.mediumLightGray)
    }
    
    
    var body: some View {
        NavigationView {
            VStack {
                TabView(selection: $viewModel.selectedIndex) {
                    WeekOverviewScreen()
                        .tabItem {
                            Label(
                                "Week Overview",
                                systemImage: "doc.text.magnifyingglass"
                            )
                        }
                        .tag(0)

                    WeeklyBreakdownScreen()
                        .tabItem {
                            Label(
                                "Daily Breakdown",
                                systemImage: "calendar"
                            )
                        }
                        .tag(1)

                    TaskListsScreen()
                        .tabItem {
                            Label(
                                "Lists",
                                systemImage: "list.bullet"
                            )
                        }
                        .tag(2)
                }
                .tint(CustomColours.ctaGold)
            }
        }
        // Load default daily schedules if appropriate
        .onReceive(dailySchedules.publisher.collect()) { schedules in
            if schedules.isEmpty {
                viewModel.addDefaultDailySchedules(moc: moc)
            }
        }
    }
}


struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
