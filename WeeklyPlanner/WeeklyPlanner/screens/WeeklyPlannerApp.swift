//
//  WeeklyPlannerApp.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2023-12-26.
//

import SwiftUI

@main
struct WeeklyPlannerApp: App {
    
    @StateObject private var dataController = CoreDataController()

    var body: some Scene {
        WindowGroup {
            MainView(viewModel: MainViewModel())
                .environment(\.managedObjectContext, dataController.moc)
        }
    }
}
