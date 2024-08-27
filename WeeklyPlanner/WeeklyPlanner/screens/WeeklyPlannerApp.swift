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
            MainScreen()
                .environment(\.managedObjectContext, dataController.moc)
        }
    }
}
