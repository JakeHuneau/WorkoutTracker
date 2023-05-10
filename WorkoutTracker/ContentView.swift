//
//  ContentView.swift
//  WorkoutTracker
//
//  Created by Jake Huneau on 3/27/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            WorkoutView()
                .tabItem {
                    Label("Workout", systemImage: "figure.walk")
                }
            
            HistoryView()
                .tabItem {
                    Label("History", systemImage: "calendar")
                }
            
//            StatsView()
//                .tabItem {
//                    Label("Stats", systemImage: "number")
//                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
