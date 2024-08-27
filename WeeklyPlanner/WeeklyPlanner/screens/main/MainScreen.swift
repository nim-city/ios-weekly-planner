//
//  MainScreen.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-05-06.
//

import Foundation
import SwiftUI

struct MainScreen: View {
    // UI specific
    @State private var selectedTabIndex = 0

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
                                "Week Breakdown",
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
            }
        }
    }
}


struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
