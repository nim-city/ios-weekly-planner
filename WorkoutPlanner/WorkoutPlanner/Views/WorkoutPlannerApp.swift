//
//  WorkoutPlannerApp.swift
//  WorkoutPlanner
//
//  Created by Nimish Narang on 2025-05-14.
//

import SwiftUI

@main
struct WorkoutPlannerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
