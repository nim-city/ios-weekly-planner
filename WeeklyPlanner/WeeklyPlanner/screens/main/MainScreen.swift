//
//  MainScreen.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-05-06.
//

import SwiftUI


struct MainScreen: View {
    // UI specific
    @State private var selectedTabIndex = 0

    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor(CustomColours.mediumLightGray)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TabView(selection: $selectedTabIndex) {
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
    }
}


struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
