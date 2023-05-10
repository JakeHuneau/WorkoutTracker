//
//  WorkoutTrackerApp.swift
//  WorkoutTracker
//
//  Created by Jake Huneau on 3/27/23.
//

import SwiftUI

@main
struct WorkoutTrackerApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environment(\.colorScheme, .light)
        }
    }
}
